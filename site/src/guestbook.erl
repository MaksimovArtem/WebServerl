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


body() ->

  wf:defer(comment, name, #validate{validators=[
    #is_required{text="Name Required"}]}),
  wf:defer(comment, message, #validate{validators=[
    #is_required{text="Message Required"}]}),


  Comm = db_comment:dump_comments(),

  F = fun(C1,C2) ->
    C1#comment.id =< C2#comment.id
  end,

  Comments = lists:sort(F,Comm),

  Pretty = fun(Comment) ->
    [
    #br{},
    #h1{text = Comment#comment.name},
    #br{},
    #span{text = Comment#comment.message},
    #br{}
    ]
  end,
  View = lists:map(Pretty, Comments),
  View ++
  [
    #br{},
    #textbox{id=name, next=message, size=100, placeholder="Name"},
    #br{},
    #br{},
    #textarea{id=message, trap_tabs=true, columns=101, rows=10, placeholder="Your comment"},
    #br{},
    #br{},
    #link{id=comment, postback=save, image="images/sendcomment10x2_2.jpg", style="position: relative;
                                                                                  display: flex;
                                                                                  left: 260px;"}
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
  wf:redirect("/guestbook").
