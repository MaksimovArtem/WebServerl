%% -*- mode: nitrogen -*-
-module (contact).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").

-include("visitors.hrl").

main() -> #template { file = "./site/templates/me.html" }.

title() -> "My info".

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
  
header() ->
		[
						#singlerow{cells=[#listitem{body=[#link{postback=home, text=" HOME "}],style="display: inline-block;
																																													margin-right: 10px"},

															#listitem{body=[#p{text="•"}],style="display: inline-block;
																																	 margin-left: 10px;
																																	 margin-right: 10px"},

															#listitem{body=[#link{postback=portrait, text=" PORTRAIT "}],style="display: inline-block;
																																																	margin-left: 10px;
																																																	margin-right: 10px;"},

															#listitem{body=[#p{text="•"}],style="display: inline-block;
																																	 margin-left: 10px;
																																	 margin-right: 10px"},

															#listitem{body=[#link{postback=nature, text=" NATURE "}],style="display: inline-block;
																																															margin-left: 10px;
																																															margin-right: 10px;"},

															#listitem{body=[#p{text="•"}],style="display: inline-block;
																																	 margin-left: 10px;
																																	 margin-right: 10px"},

															#listitem{body=[#link{postback=reportage, text=" REPORTAGE "}],style="display: inline-block;
																																																		margin-left: 10px;
																																																		margin-right: 10px;"}]},

															#listitem{body=[#p{text="•"}],style="display: inline-block;
																																	 margin-left: 10px;
																																	 margin-right: 10px"},

															#listitem{body=[#link{postback=about_me, text=" CONTACT "}],style="display: inline-block;
																																																 margin-left: 10px;
																																																 margin-right: 10px;"},

															#listitem{body=[#p{text="•"}],style="display: inline-block;
																																	 margin-left: 10px;
																																	 margin-right: 10px"},                                                                                                  

															#listitem{body=[#link{postback=guestbook, text=" GUESTBOOK "}],style="display: inline-block;
																																																	 margin-left: 10px;"}
		].

body() ->
	case wf:user() of
		undefined ->
			wf:defer(message, name, #validate{validators=[
				#is_required{text="Name Required"}]}),
			wf:defer(message, mail, #validate{validators=[
				#is_email{text="E-mail Address Required"},
				#is_required{text="E-mail Address Required"}]}),
			wf:defer(message, message, #validate{validators=[
				#is_required{text="Message Required"}]}),
			[
				#br{},
				#h4{text = "Здравствуйте, меня зовут Елькина Варвара, я начинающий фотограф."}, 
				#h4{text = "Люблю фотографировать природу и людей. Также занимаюсь репортажной съемкой. "},
				#br{},
				#br{},
				#h4{text="Россия. г. Нижний Новгород"},
				#br{},
				#h4{text = "Пожалуйста используйте форму ниже, чтобы связаться со мной"},
				#br{},
				#br{},
				#textbox{id=name, size=100, placeholder="Name"},
				#br{},
				#br{},
				#textbox{id=mail, size=100, placeholder="E-mail"},
				#br{},
				#br{},
				#textarea{id=message, trap_tabs=true, columns=101, rows=10, placeholder="Your message"},
				#br{},
				#br{},

				#link{id = message, postback = save, image="images/sendmessage10x2_2.jpg", style="position: relative;
																                                  display: flex;
																                                  left: 310px;"}
			];
		_Username ->
			Pretty = fun(Message) ->
		        [
		        #br{},
		        #h1{text = Message#message.name ++ " " ++ Message#message.time},
		        #br{},
		        #br{},
		        #h1{text = Message#message.mail},
		        #br{},
		        #br{},
		        #p{text = Message#message.message},
		        #br{}
		        ]
		    end,
		    Mess = db_message:dump_messages(),
		    View =
		    case length(Mess) of
		    	0 -> [];
		    	1 ->
			      lists:map(Pretty, Mess);
			    _Number ->
			      F = fun(M1,M2) ->
			        M1#message.id =< M2#message.id
			      end,
			      Messages = lists:sort(F,Mess),
			      lists:map(Pretty, Messages)
			end,
			View
	end.

footer() ->
		[
						#singlerow{cells=[#listitem{body=[#link{text="", image="images/vkontakte.png", url="https://vk.com"}],
																				style="display: inline-block;
																							 margin-left: 20px;
																							 margin-right: 20px"},

															#listitem{body=[#link{text="", image="images/instagram.png", url="https://www.instagram.com"}],
																				style="display: inline-block;
																							 margin-left: 20px;
																							 margin-right: 20px;"}]}        
		].

event(home) ->
		wf:redirect("/");
event(about_me) ->
		wf:redirect("/contact");
event(nature) ->
		wf:redirect("/nature");
event(portrait) ->
		wf:redirect("/portrait");
event(reportage) ->
		wf:redirect("/reportage");
event(guestbook) ->
	wf:redirect("/guestbook");
	
event(save) ->
	[Name, Mail, Message] = wf:mq([name, mail, message]),
	db_message:add_message(Name, Mail, Message),
    wf:redirect("/");

event(logout) ->
  wf:logout(),
  wf:redirect("/").