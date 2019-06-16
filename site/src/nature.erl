%% -*- mode: nitrogen -*-
-module (nature).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").

main() -> #template { file="./site/templates/ordinary_page.html" }.

title() -> "Nature".

body() ->
    [
      #h1{text="Hi, these are photo of nature"},
      #p{text="Waiting for Varya's model"}
    ].
