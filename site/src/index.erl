%% -*- mode: nitrogen -*-
-module (index).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").

main() -> #template { file="./site/templates/bare.html" }.

title() -> "Welcome to this WebSite".


body() ->

    visitors_db:start(),
    [
        #h1 { text = "Welcome!" },
        #h2 { text = "You've been busted"}
    ].
