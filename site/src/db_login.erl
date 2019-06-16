-module(db_login).

-behaviour(gen_server).

-include("visitors.hrl").
-include_lib("stdlib/include/qlc.hrl").

-export([init/1, handle_call/3, handle_cast/2, handle_info/2,terminate/2,code_change/3]).


-export([start/0, stop/0]).

%change db
-export([create_account/2,remove/1]).

-define(DB_LOGIN, db_login).

%% @doc start server with mnesia database
start() ->
	gen_server:start_link({local, ?DB_LOGIN},?MODULE,[],[]).
%% @doc stop server with mnesia database
stop() ->
	gen_server:call(?DB_LOGIN, stop).
%% @doc insert account in database
create_account(Username, Password) ->
	gen_server:call(?DB_LOGIN, {create_account, Username, Password}).
%% @doc remove account from database
remove(Name) ->
	gen_server:call(?DB_LOGIN, {remove,Name}).

init(_Args) ->
	mnesia:start(),
	mnesia:create_table(login, [{attributes, record_info(fields, login)}]),
	{ok,login}.

%%---------------------------------------
%%callbacks
%%---------------------------------------
handle_call({create_account, Username, Password}, _From, Tab) ->
	PWHash = erlpass:hash(term_to_binary(Password)),
	Row = #login{username = Username, password = PWHash},
	io:format("R: ~p\n",[Row]),
	Reply = 
	case get_account(Row#login.username,Tab) of
		{atomic,[]} ->
			F = fun() -> mnesia:write(Tab, Row, write) end,
			mnesia:transaction(F),
			ok;
		{atomic, _} -> already_inserted
	end,

	{atomic, Shit} = get_account(Row#login.username,Tab),
	io:format("S ~p",[Shit]),
	{reply, Reply, Tab};

handle_call({remove,Key}, _From, Tab) ->
	ObjectID = {Tab, Key},
	F = fun() -> mnesia:delete(ObjectID) end,
	mnesia:transaction(F),
	{reply, ok, Tab};

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
get_account(Key, Tab) ->
	F = fun() -> mnesia:read(Tab, Key, write) end,
	mnesia:transaction(F).