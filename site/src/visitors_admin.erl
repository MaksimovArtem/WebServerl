-module (visitors_admin).
-compile(export_all).

-include_lib ("nitrogen_core/include/wf.hrl").
-include("visitors.hrl").

main() ->
	#template{
	file="./site/templates/page_db.html"}.

title() ->
	"Admin Visitor".

body_1() ->
	[	
		#h1{ text="Visitors" },
		#h3{text="Enter appointment"}
	].

body() ->
	[
		#label {text="Date"},
		#datepicker_textbox{
			id=date1,
			options=[{dateFormat, "mm/dd/yy"},
					 {showButtonPanel, true}]},

		#br{},
			#label{text="Time"},
			time_dropdown(),
		#br{},

		#label{text="Name"},
		#textbox{id=name, next=city},
		
		#br{},
			#label{text="City"},
			#textbox{id=city},
		#br{},

		#button{postback=done, text="Done"},
		#button{id=save, postback=save, text="Save"}
	].

inner_body() ->
	wf:defer(save, name,
		     #validate{validators=[
			 #is_required{text="Name or Company is required",
			 unless_has_value=company}]}).

time_dropdown() ->
	Hours = lists:seq(8,17),
	#dropdown {id=time, options=[time_option({H,0,0}) || H <- Hours]}.

time_option(T={12,0,0}) ->
	#option{text="12:00 noon", value=wf:pickle(T)};

time_option(T={H,0,0}) when H =< 11 -> 
	#option{text=wf:to_list(H) ++ ":00 am",	value=wf:pickle(T)};

time_option(T={H,0,0}) when H > 12 ->
	#option{text=wf:to_list(H-12) ++ ":00 pm", value=wf:pickle(T)}.

parse_date(Date) ->
	[M,D,Y] = string:tokens(Date,"/"),
	{wf:to_integer(Y), wf:to_integer(M), wf:to_integer(D)}.

event(done) ->
	wf:wire(#confirm{text="Done?", postback=done_ok});

event(done_ok) ->
	wf:redirect("/");

event(save) ->
	wf:wire(#confirm{text="Save?", postback=confirm_ok});

event(confirm_ok) ->
	save_visitor(),
	wf:wire(#clear_validation{}),
	wf:update(inner_body, inner_body()).

save_visitor() ->
	Name = wf:q(name),
	City = wf:q(city),
	% Date = parse_date(wf:q(date1)),
	% Time = wf:depickle(wf:q(time)),
	% Record = #visitor{name=Name, city=City,
	% 				  date=Date, time=Time},
	visitors_db:insert(Name,City).