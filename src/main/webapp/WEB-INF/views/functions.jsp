<%-- 
    Document   : arithmetic
    Author     : Team ENMAKA
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>

<!DOCTYPE html>
<html lang="no">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width= device-witdh, initial-scale = 1">
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"> 
        <title>Funksjon oppgave</title>
        <style>
            .form-control {
                width: 20%;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/WEB-INF/views/menu.jsp"/>
        <jsp:include page="/WEB-INF/views/styling.jsp"/>
        <div class="container">
            <div class="jumbotron">
                <div class="page-header">
                    <p class="text-center">Oppgave av typen Funksjoner</p>
                </div>
                <div>
                    <script type="text/javascript" src="https://www.geogebra.org/scripts/deployggb.js"></script>
                    <script type="text/javascript">

                        var parameters = {"prerelease": false, "width": 800, "height": 600, "showToolBar": true, "borderColor": null, "showMenuBar": true, "showAlgebraInput": false,
                            "showResetIcon": true, "enableLabelDrags": false, "enableShiftDragZoom": true, "enableRightClick": false, "capturingThreshold": null, "showToolBarHelp": false,
                            "errorDialogsActive": true, "useBrowserForJS": false};

                        var applet = new GGBApplet('5.0', parameters);

                        applet.setJavaCodebase('GeoGebra/Java/5.0');

                        window.onload = function () {
                            applet.inject('applet_container', 'preferHTML5');
                        }
                    </script>

                    <div id="applet_container"></div>
                    
                    <div class="col-lg-3"><a class="btn btn-primary btn-lg" href="createtaskview">Tilbake</a></div>
                </div>
            </div>
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    </body>
</html>
