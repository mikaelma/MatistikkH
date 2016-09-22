<%-- 
    Document   : createtask
    Author     : Team ENMAKA
--%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="no">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width= device-width, initial-scale = 1">
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
        <title>Funksjoner</title>
    </head>
    <body>
        <jsp:include page="/WEB-INF/views/menu.jsp"/>
        <jsp:include page="/WEB-INF/views/styling.jsp"/>
        <div class="container">
            <div class="jumbotron"> 
                
                <h3>Oppgave </h3>
                    <div  id="questionGroup" class="panel-group">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <a data-toggle="collapse" href="#collapse1">Oppgavetekst</a>
                                </h4>
                            </div>
                            <div id="collapse1" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <textarea rows="4" cols="40" ></textarea>
                                    <button onclick="">Legg til graf</button>
                                    <button onclick="">Legg til bilde</button>
                                </div>
                            </div>
                        </div>                 
                        <div class="panel panel-default">
                            <div class =" panel-heading">
                                <h4 class="panel-title">
                                    <a data-toggle="collapse" href="#collapse2">Legg til GeoGebra</a>
                                </h4>
                            </div>
                            <div id="collapse2" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <div>
                                    <script type="text/javascript" src="https://www.geogebra.org/scripts/deployggb.js"></script>
                                    <script type="text/javascript">

                                        var parameters = {"prerelease": false, "showToolBar": true, "borderColor": null, "showMenuBar": true, "showAlgebraInput": false,
                                            "showResetIcon": true, "enableLabelDrags": false, "enableShiftDragZoom": true, "enableRightClick": false, "capturingThreshold": null, "showToolBarHelp": false,
                                            "errorDialogsActive": true, "useBrowserForJS": false};

                                        var applet = new GGBApplet('5.0', parameters);

                                        applet.setJavaCodebase('GeoGebra/Java/5.0');

                                        window.onload = function () {
                                            applet.inject('applet_container', 'preferHTML5');
                                        }
                                    </script>
                                    <div id="applet_container"></div>
                                </div>
                                </div>
                            </div>
                        </div>                 
                
                 <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <a data-toggle="collapse" href="#collapse3">Flervalgsoppgaver</a>
                                </h4>
                            </div>
                            <div id="collapse3" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <textarea rows="4" cols="40" ></textarea>                                   
                                </div>
                            </div>
                        </div>                 
                </div>
                
                         
                  
            <h3>Svar</h3>
            <div  id="questionGroup" class="panel-group">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <a data-toggle="collapse" href="#collapse4">Oppgavetekst</a>
                                </h4>
                            </div>
                            <div id="collapse4" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <textarea rows="4" cols="40" ></textarea>
                                    <button onclick="">Legg til graf</button>
                                    <button onclick="">Legg til bilde</button>
                                </div>
                            </div>
                        </div>                 
                        <div class="panel panel-default">
                            <div class =" panel-heading">
                                <h4 class="panel-title">
                                    <a data-toggle="collapse" href="#collapse5">Legg til GeoGebra</a>
                                </h4>
                            </div>
                            <div id="collapse5" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <div>
                                    <script type="text/javascript" src="https://www.geogebra.org/scripts/deployggb.js"></script>
                                    <script type="text/javascript">

                                        var parameters = {"prerelease": false, "showToolBar": true, "borderColor": null, "showMenuBar": true, "showAlgebraInput": false,
                                            "showResetIcon": true, "enableLabelDrags": false, "enableShiftDragZoom": true, "enableRightClick": false, "capturingThreshold": null, "showToolBarHelp": false,
                                            "errorDialogsActive": true, "useBrowserForJS": false};

                                        var applet = new GGBApplet('5.0', parameters);

                                        applet.setJavaCodebase('GeoGebra/Java/5.0');

                                        window.onload = function () {
                                            applet.inject('applet_container', 'preferHTML5');
                                        }
                                    </script>
                                    <div id="applet_container"></div>
                                </div>
                                </div>
                            </div>
                        </div>                 
                
                 <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <a data-toggle="collapse" href="#collapse6">Flervalgsoppgaver</a>
                                </h4>
                            </div>
                            <div id="collapse6" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <textarea rows="4" cols="40" ></textarea>                                   
                                </div>
                            </div>
                        </div>                 
                </div>
              <div class="col-lg-1"><a class="btn btn-primary btn-lg" href="choosetypeview">Tilbake</a></div>
                    <div class="col-sm-offset-5"><a class="btn btn-success btn-lg" href="">Send inn oppgave</a></div>                            
            </div> 
            
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    </body>
</html>
