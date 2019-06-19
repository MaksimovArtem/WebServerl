%% -*- mode: nitrogen -*-
-module (index).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").

main() -> #template { file="./site/templates/home.html" }.

title() -> "Welcome to this WebSite".

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
    visitors_db:start(),
    db_login:start(),
    db_login:create_account("admin", "admin"),
    db_message:start(),
    db_comment:start(),
    [].

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

%pages
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

event(logout) ->
  wf:logout(),
  wf:redirect("/").