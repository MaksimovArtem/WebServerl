%%  coding: latin-1
%%------------------------------------------------------------
%%
%% Implementation stub file
%% 
%% Target: CosNotification_EventTypeSeq
%% Source: /build/erlang-khbCpQ/erlang-20.2.2+dfsg/lib/cosNotification/src/CosNotification.idl
%% IC vsn: 4.4.3
%% 
%% This file is automatically generated. DO NOT EDIT IT.
%%
%%------------------------------------------------------------

-module('CosNotification_EventTypeSeq').
-ic_compiled("4_4_3").


-include("CosNotification.hrl").

-export([tc/0,id/0,name/0]).



%% returns type code
tc() -> {tk_sequence,{tk_struct,"IDL:omg.org/CosNotification/EventType:1.0",
                                "EventType",
                                [{"domain_name",{tk_string,0}},
                                 {"type_name",{tk_string,0}}]},
                     0}.

%% returns id
id() -> "IDL:omg.org/CosNotification/EventTypeSeq:1.0".

%% returns name
name() -> "CosNotification_EventTypeSeq".



