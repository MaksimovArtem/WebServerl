%% -*- mode: nitrogen -*-
-module (portraite).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").

main() -> #template { file="./site/templates/ordinary_page.html" }.

title() -> "Portraites".

body() ->
    [
      #h1{text="Portraites"},
      #p{text="Waiting for Varya's model"}
    ].
