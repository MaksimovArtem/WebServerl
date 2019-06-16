%% -*- mode: nitrogen -*-
-module (login_page).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").

main() -> #template { file="./site/templates/ordinary_page.html" }.

title() -> "The login page".

body() ->
	case wf:user() of
		undefined ->
			[
				"Not Logged in.",
				#br{},
				#link{text="Log In", url="/login"},
				"  or  ",
				#link{text="Create an Account", url="/create_account"}
			];
		Username ->
			[
				#span{text=["Logged in as ", Username,". "]},
				#br{},
				#link{text="Log out", postback=logout}
			]
	end.

event(logout) ->
	wf:logout(),
	wf:redirect("/").
