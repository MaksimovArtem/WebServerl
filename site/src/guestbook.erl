%% -*- mode: nitrogen -*-
-module (guestbook).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").

-include("visitors.hrl").

main() -> #template { file="./site/templates/ordinary_page.html" }.

title() -> "Guestbook".

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

  wf:defer(comment, name, #validate{validators=[
    #is_required{text="Name Required"}]}),
  wf:defer(comment, message, #validate{validators=[
    #is_required{text="Message Required"}]}),

  Pretty = fun(Comment) ->
    case wf:user() of
      undefined ->
        [
          #br{},
          #h1{text = Comment#comment.name},
          #br{},
          #br{},
          #p{text = Comment#comment.message},
          #br{}
        ];
      _Username ->
        [
        #br{},
        #singlerow{cells=[#listitem{body = [#h1{text = Comment#comment.name}], style="display: inline-block;
                                                                                     margin-right: 10px"},
                          #listitem{body = [#button{text = "Delete Comment", postback = {delete, Comment#comment.id}}], style="display: inline-block;"} ]},
        #br{},
        #br{},
        #p{text = Comment#comment.message},
        #br{}
        ]
    end
  end,

  Comm = db_comment:dump_comments(),

  View =
  case length(Comm) of
    0 -> [];
    1 ->
      lists:map(Pretty, Comm);
    _Number ->
      F = fun(C1,C2) ->
        C1#comment.id =< C2#comment.id
      end,
      Comments = lists:sort(F,Comm),
      lists:map(Pretty, Comments)
  end,

  View ++
  [
    #br{},
    #textbox{id=name, next=message, size=100, placeholder="Name", maxlength = 20},
    #br{},
    #br{},
    #textarea{id=message, trap_tabs=true, columns=101, rows=10, placeholder="Your comment"},
    #br{},
    #br{},
    #link{id=comment, postback=save, image="images/sendcomment10x2_2.jpg", style="position: relative;
                                                                                  display: flex;
                                                                                  left: 310px;"}
  ].

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
  Name = wf:q(name),
  Message = wf:q(message),
  db_comment:add_comment(Name, Message),
  wf:redirect("/guestbook");

event({delete,Id}) ->
  db_comment:remove(Id),
  wf:redirect("/guestbook");

event(logout) ->
  wf:logout(),
  wf:redirect("/").
