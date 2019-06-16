%% -*- mode: nitrogen -*-
-module (index).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").

main() -> #template { file="./site/templates/bare.html" }.

title() -> "Welcome to this WebSite".


header() ->
    [
            #singlerow{cells=[#listitem{body=[#link{postback=home, text=" Home ", image="images/home.png"}],style="display: inline-block;
                                                                                          margin-left: 20px;
                                                                                          margin-right: 20px"},

                              #listitem{body=[#link{postback=about_me, text=" About Me ", image="images/aboutme.png"}],style="display: inline-block;
                                                                                                  margin-left: 20px;
                                                                                                  margin-right: 20px;"},

                              #listitem{body=[#link{postback=nature, text=" Nature ", image="images/nature.png"}],style="display: inline-block;
                                                                                              margin-left: 20px;
                                                                                              margin-right: 20px;"},

                              #listitem{body=[#link{postback=portrait, text=" Portrait ", image="images/portrait.png"}],style="display: inline-block;
                                                                                                    margin-left: 20px;
                                                                                                    margin-right: 20px;"},

                              #listitem{body=[#link{postback=reportage, text=" Reportage ", image="images/reportage.png"}],style="display: inline-block;
                                                                                                    margin-left: 20px;
                                                                                                    margin-right: 20px;"}]}
    ].

body() ->
    visitors_db:start(),
    db_login:start(),
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
                                               margin-right: 20px;"},

                              #listitem{body=[#link{text="", image="images/facebook.png", url="https://www.facebook.com"}],
                                        style="display: inline-block;
                                               margin-left: 20px;
                                               margin-right: 20px;"}]}        
    ].

%pages
event(home) ->
    wf:redirect("/");
event(about_me) ->
    wf:redirect("/aboutme");
event(nature) ->
    wf:redirect("/nature");
event(portrait) ->
    wf:redirect("/portraite");
event(reportage) ->
    wf:redirect("/reportage").