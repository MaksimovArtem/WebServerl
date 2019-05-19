-module(visitors_db).
-behaviour(gen_server).

-include("visitors.hrl").
-include_lib("stdlib/include/qlc.hrl").

-export([init/1, handle_call/3, handle_cast/2, handle_info/2,terminate/2,code_change/3]).


-export([start/0, stop/0]).

%change db
-export([insert/2,remove/1]).

%get info from db
-export([all_names/0,
		 get_today_visitors/0,
		 dump_visitors/0]).

-define(VISITORS_DB, visitors_db).

%% @doc start server with mnesia database
start() ->
	gen_server:start_link({local, ?VISITORS_DB},?MODULE,[],[]).
%% @doc stop server with mnesia database
stop() ->
	gen_server:call(?VISITORS_DB, stop).
%% @doc insert visitor in database
insert(Name,City) ->
	gen_server:call(?VISITORS_DB, {insert_visitor, Name,City}).
%% @doc remove visitor from database
remove(Name) ->
	gen_server:call(?VISITORS_DB, {remove,Name}).
%% @doc return all names from database
all_names() ->
	gen_server:call(?VISITORS_DB, all_names).
%% @doc return all visitors that update database today
get_today_visitors() ->
	gen_server:call(?VISITORS_DB, get_today_visitors).
%% @doc return list of records with all visitors
dump_visitors() ->
	gen_server:call(?VISITORS_DB, dump_visitors).

init(_Args) ->
	mnesia:start(),
	mnesia:create_table(visitor, [{attributes, record_info(fields, visitor)}]),
	{ok,visitor}.

%%---------------------------------------
%%callbacks
%%---------------------------------------
handle_call({insert_visitor, Key,City}, _From, Tab) ->
	{Date,Time} = calendar:local_time(),
	Row = #visitor{name = Key,city=City,date = Date,time = Time},
	Reply = 
	case get_visitor(Row#visitor.name,Tab) of
		{atomic,[]} ->
			F = fun() -> mnesia:write(Tab,Row,write) end,
			mnesia:transaction(F),
			ok;
		{atomic,_} -> already_inserted
	end,
	{reply, Reply, Tab};

handle_call({remove,Key}, _From, Tab) ->
	ObjectID = {Tab, Key},
	F = fun() -> mnesia:delete(ObjectID) end,
	mnesia:transaction(F),
	{reply, ok, Tab};

handle_call(all_names, _From, Tab) ->
	F = fun() ->
		mnesia:select(Tab, [{#visitor{name = '$1',_ ='_'},[],['$1']}])
	end,
	Reply = regular_transaction(F),
	{reply, Reply,Tab};

handle_call(get_today_visitors, _From, Tab) ->
	{Today,_Now} = calendar:local_time(),
	F = fun() ->
		mnesia:select(Tab, [{#visitor{name='$1',date = Today,_ ='_'},[],['$1']}])
	end,
	Reply = regular_transaction(F),
	{reply, Reply,Tab};

handle_call(dump_visitors,_From, Tab) ->
	F = fun() -> mnesia:match_object({visitor,'_','_','_','_'}) end,
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
get_visitor(Key, Tab) ->
	F = fun() -> mnesia:read(Tab,Key,write)	end,
	mnesia:transaction(F).

regular_transaction(F) ->
	case mnesia:transaction(F) of
		{atomic,[]} -> none;
		{atomic,List} -> List
	end.