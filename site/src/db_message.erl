-module(db_message).

-behaviour(gen_server).

-include("visitors.hrl").
-include_lib("stdlib/include/qlc.hrl").

-export([init/1, handle_call/3, handle_cast/2, handle_info/2,terminate/2,code_change/3]).


-export([start/0, stop/0]).

%change db
-export([add_message/3,remove/1]).

-export([dump_messages/0]).

-define(DB_MESSAGE, db_message).

%% @doc start server with mnesia database
start() ->
	gen_server:start_link({local, ?DB_MESSAGE},?MODULE,[],[]).
%% @doc stop server with mnesia database
stop() ->
	gen_server:call(?DB_MESSAGE, stop).
%% @doc insert message in database
add_message(Name, Email, Message) ->
	gen_server:call(?DB_MESSAGE, {add_message, Name, Email, Message}).
%% @doc remove message from database
remove(Email) ->
	gen_server:call(?DB_MESSAGE, {remove, Email}).
dump_messages() ->
	gen_server:call(?DB_MESSAGE, dump_messages).

init(_Args) ->
	mnesia:start(),
	mnesia:create_table(message, [{attributes, record_info(fields, message)}]),
	{ok, message}.

%%---------------------------------------
%%callbacks
%%---------------------------------------
handle_call({add_message, Name, Email, Message}, _From, Tab) ->
	Id = length(mnesia:dirty_all_keys(Tab)) + 1,
	{Y, M, D} = erlang:date(),
	Row = #message{id = Id, mail = Email, name = Name, message = Message, time = string:join([integer_to_list(D),integer_to_list(M),integer_to_list(Y)], ".")},
	Reply = 
	case get_message(Row#message.id, Tab) of
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

handle_call(dump_messages,_From, Tab) ->
	F = fun() -> mnesia:match_object({message,'_','_','_','_','_'}) end,
	R = regular_transaction(F),
	Reply = 
	case R of
		none -> [];
		_ -> R
	end, 
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
get_message(Key, Tab) ->
	F = fun() -> mnesia:read(Tab, Key, write) end,
	mnesia:transaction(F).

regular_transaction(F) ->
	case mnesia:transaction(F) of
		{atomic,[]} -> none;
		{atomic,List} -> List
	end.