-module (visitors_admin).
-compile(export_all).

-include_lib ("nitrogen_core/include/wf.hrl").
-include("visitors.hrl").

main() ->
	#template{
	file="./site/template/bare.html"}.

title() ->
	"Admin Visitor".

body() ->
	#panel{id=inner_body, body=inner_body()}.

inner_body() ->
	wf:defer(save, name,
		     #validate{validators=[
			 #is_required{text="Name or Company is required",
			 unless_has_value=company}]}).