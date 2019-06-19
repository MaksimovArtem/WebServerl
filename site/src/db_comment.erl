-module(db_comment).

-behaviour(gen_server).

-include("visitors.hrl").
-include_lib("stdlib/include/qlc.hrl").

-export([init/1, handle_call/3, handle_cast/2, handle_info/2,terminate/2,code_change/3]).


-export([start/0, stop/0]).

%change db
-export([add_comment/2,remove/1]).

-export([dump_comments/0]).

-define(DB_COMMENT, db_comment).

%% @doc start server with mnesia database
start() ->
	gen_server:start_link({local, ?DB_COMMENT},?MODULE,[],[]).
%% @doc stop server with mnesia database
stop() ->
	gen_server:call(?DB_COMMENT, stop).
%% @doc insert comment in database
add_comment(Name, Message) ->
	gen_server:call(?DB_COMMENT, {add_comment, Name, Message}).
%% @doc remove comment from database
remove(Id) ->
	gen_server:call(?DB_COMMENT, {remove, Id}).
%% @doc return list of records with all comments
dump_comments() ->
	gen_server:call(?DB_COMMENT, dump_comments).

init(_Args) ->
	mnesia:start(),
	mnesia:create_table(comment, [{attributes, record_info(fields, comment)}]),
	{ok, comment}.

%%---------------------------------------
%%callbacks
%%---------------------------------------
handle_call({add_comment, Name, Message}, _From, Tab) ->
	Id = length(mnesia:dirty_all_keys(Tab)) + 1,
	Row = #comment{id = Id, name = Name, message = Message},
	Reply = 
	case get_comment(Row#comment.id, Tab) of
		{atomic,[]} ->
			F = fun() -> mnesia:write(Tab, Row, write) end,
			mnesia:transaction(F),
			ok;
		{atomic, _} -> already_inserted
	end,
	{reply, Reply, Tab};

handle_call({remove,Key}, _From, Tab) ->
	ObjectID = {Tab, Key},
	F = fun() -> mnesia:delete(ObjectID) end,
	mnesia:transaction(F),
	{reply, ok, Tab};

handle_call(dump_comments,_From, Tab) ->
	F = fun() -> mnesia:match_object({comment,'_','_','_'}) end,
	Reply = regular_transaction(F),
	{reply, Reply,Tab};

handle_call(stop,_From,_List) ->
	mnesia:stop(),
	{stop,normal,terminated, []}.

%%---------------------------------------
%%mandatory functions
%%---------------------------------------
handle_cast(_Request, State) ->
	{noreply, State}.
handle_info(_Info, State) -> 
	{noreply, State}.
terminate(_Reason, _State) ->
	ok.
code_change(_OldVsn, State, _Extra) ->
	{ok, State}.

%%---------------------------------------
%%internal functions
%% TODO: move to another file!
%%---------------------------------------
get_comment(Key, Tab) ->
	F = fun() -> mnesia:read(Tab, Key, write) end,
	mnesia:transaction(F).

regular_transaction(F) ->
	case mnesia:transaction(F) of
		{atomic,[]} -> none;
		{atomic,List} -> List
	end.