%% -*- mode: nitrogen -*-
-module (reportage).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").

main() -> #template { file="./site/templates/ordinary_page.html" }.

title() -> "Reportages".

body() ->
    [
      #h1{text="Reportages"},
      #p{text="Waiting for Varya's model"}
    ].
