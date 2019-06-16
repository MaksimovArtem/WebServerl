%% -*- mode: nitrogen -*-
-module (index).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").

main() -> #template { file="./site/templates/bare.html" }.

title() -> "Welcome to this WebSite".


header() ->
    [
            #singlerow{cells=[#listitem{body=[#button{postback=home, text="Home"}],style="display: inline-block;margin-left: 20px;
                                                                                                                margin-right: 20px"},
                              #listitem{body=[#button{postback=about_me, text="About Me"}],style="display: inline-block;margin-left: 20px;
                                                                                                                        margin-right: 20px;"},
                              #listitem{body=[#button{postback=nature, text="Nature"}],style="display: inline-block;margin-left: 20px;
                                                                                                                    margin-right: 20px;"},
                              #listitem{body=[#button{postback=portraite, text="Portraite"}],style="display: inline-block;margin-left: 20px;
                                                                                                                          margin-right: 20px;"},
                              #listitem{body=[#button{postback=reportage, text="Reportage"}],style="display: inline-block;margin-left: 20px;
                                                                                                                          margin-right: 20px;"}]}
    ].

body() ->
    visitors_db:start(),
    db_login:start(),
    [].

footer() ->
    [
            #singlerow{cells=[#listitem{body=[#button{postback=vk, text="VKontakte"}],style="display: inline-block;margin-left: 20px;
                                                                                                                margin-right: 20px"},
                              #listitem{body=[#button{postback=instagram, text="Instagram"}],style="display: inline-block;margin-left: 20px;
                                                                                                                        margin-right: 20px;"},
                              #listitem{body=[#button{postback=facebook, text="Facebook"}],style="display: inline-block;margin-left: 20px;
                                                                                                                    margin-right: 20px;"}]}        
    ].

event(home) ->
    wf:redirect("/");
event(about_me) ->
    wf:redirect("/about/me");
event(nature) ->
    wf:redirect("/nature");
event(portraite) ->
    wf:redirect("portraite");
event(reportage) ->
    wf:redirect("/reportage");
event(_) ->
    wf:redirect("/visitors/admin").