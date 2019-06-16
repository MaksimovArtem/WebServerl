%% -*- mode: nitrogen -*-
-module (aboutme).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").

main() -> #template { file = "./site/templates/ordinary_page.html" }.

title() -> "My info".

body() ->
    [
      #h1{text="Hi, this is info about me"},
      #p{text="Waiting for Varya's model"}
    ].
