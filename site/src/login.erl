-module(login).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").

main() -> #template{file="site/templates/ordinary_page.html"}.

title() -> "Log In".

admin_place() ->
  case wf:user() of
    "admin" ->
      [
      #p{text = "You are admin"},
      #button{text="Log out", postback=logout}
      ];
    _ ->
      []
  end.
  

body() ->
wf:defer(login, username, #validate{validators=[
	#is_required{text="Username Required"}]}),
wf:defer(login, password, #validate{validators=[
	#is_required{text="Password Required"}]}),
case wf:user() of
		undefined ->
			[
				#br{},
				#h1{text = "This is a login page for admin"},
				#br{},
				#p{text = "Please close it if you are user"},
				#br{},
				#textbox{id=username,placeholder = "Username"},
				#br{},
				#br{},
				#password{id=password, placeholder = "Password"},
				#br{},
				#br{},
				#button{id = login, text="Log In", postback=login}
			];
		Username ->
			[
				#span{text=["Logged in as ", Username,". "]},
				#br{},
				#br{},
				#button{text="Log out", postback=logout}
			]
	end.

event(login) ->
	[Username, Password] = wf:mq([username, password]),
	case db_login:attempt_login(Username, Password) of
		true ->
			wf:user(Username),
			wf:redirect("/");
		false ->
			wf:wire(#alert{text="Invalid Username or Password"})
	end;

event(logout) ->
	wf:logout(),
	wf:redirect("/").