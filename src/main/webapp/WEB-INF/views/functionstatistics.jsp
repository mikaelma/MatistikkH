<%-- 
    Document   : functionstatistics
    Author     : Team 6
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="no">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width= device-witdh, initial-scale = 1">
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"> 
        <script type="text/javascript" src="https://www.geogebra.org/scripts/deployggb.js"></script>
        <title>Funksjonsoppgave</title>
        <style>
            .container {
                height: auto !important;
            }
        </style>
    </head>
    <body onload="init()">
        <jsp:include page="/WEB-INF/views/menu.jsp"/>
        <jsp:include page="/WEB-INF/views/styling.jsp"/>
        <div class="container">
            <div class="page-header">
                <h4>Test <c:out value="${testId}"/> - Oppgave <c:out value="${answer.taskId}" /></h4>
                <h6>Besvart av: <c:out value="${answer.email}"/></h6>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    Oversikt
                </div>
                <div class="panel-body">
                    <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                        <div class="form-group">
                            <label><u>Svar</u></label>
                            <p>${functionAnswer}</p> 
                            <hr>
                            <label><u>Riktig/Galt</u></label>
                            <p><c:out value="${answer.correct ? 'Riktig' : 'Galt'}"/></p>
                            <hr>
                            <label><u>Tid brukt</u></label>
                            <p><c:out value="${answer.time}"/></p>
                            <hr>
                            <label><u>Forklaring/begrunnelse</u></label>
                            <p>${answer.explenation}</p>
                        </div>
                    </div>
                    <div class="col-lg-10 col-md-10 col-sm-12 col-xs-12">
                        <input type="hidden" id="hidden5" value="${geoBase64}">
                        <input type="hidden" id="hidden6" value="${geoListener}">
                        <div id="applet_container"></div>
                        <input type="hidden" id="hidden1">
                        <input type="hidden" id="hidden2">
                    </div>
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="panel panel-success">
                            <div class="panel-heading">
                                <h3 class="panel-title">Fremgangsmåte</h3>
                            </div>
                            <div class="panel-body"  id="geoListenerData">

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <form:form action="taskstatistics" method="POST">
                <input type="hidden" name="testId" value="${testId}">
                <input type="hidden" name="taskId" value="${answer.taskId}">
                <button type="submit" class="btn btn-primary">Tilbake</button>
            </form:form>
            <br>
        </div>
        <script type="text/javascript">
            // Scriptet som har ansvar for konfigurering og innlasting av Geogebra

            var parameters = {"prerelease": false, "width": 800, "height": 600, "borderColor": null, "showToolBar": true, "showMenuBar": true, "showAlgebraInput": false,
                "showResetIcon": false, "enableLabelDrags": false, "enableShiftDragZoom": true, "enableRightClick": false, "capturingThreshold": null, "showToolBarHelp": false,
                "errorDialogsActive": true, "useBrowserForJS": true, "enableCAS": true};


            var applet = new GGBApplet('5.0', parameters);
            applet.setJavaCodebase('GeoGebra/Java/5.0');
            window.onload = function () {
                applet.inject('applet_container', 'preferHTML5');
                fremgang();
            };
        </script>

        <script>
            // Denne metoden henter ut en lang string med data om fremgangsmåten fra databasen. 
            // Metoden behandler stringen og skriver den ut i en liste med data i riktig rekkefølge. 
            function fremgang() {
                var string = document.getElementById('hidden6').value;
                var valuediv = document.getElementById('geoListenerData');
                var tabell = string.split("|||");
                var tider = [];
                var sortert = [];
                for (var i = 0; i < tabell.length; i++) {
                    var str = tabell[i];
                    var nystr = str.substring(str.indexOf("|") + 1);
                    tider[i] = nystr;
                }

                tider.sort(function (a, b) {
                    return a - b;
                });
                for (var k = 0; k < tider.length; k++) {
                    for (var j = 0; j < tabell.length; j++) {
                        var str = tabell[j];
                        var nystr = str.substring(str.indexOf("|") + 1);
                        if (nystr == tider[k]) {
                            sortert[k] = tabell[j];
                        }
                    }
                }

                for (var g = 0; g < sortert.length; g++) {
                    valuediv.innerHTML += "<p>" + sortert[g] + " sek</p>";
                }
            }
        </script>
        <script>
            // Metodene next() og back() er påstartet som et forsøk på å lage en avspiller av fremgangsmåten
            // og prøver å bruke fremgangsmåte-listen som GeoGebra-kall. 
            // Metodene er ikke i bruk i systemet pr nå, men anbefales å videreutvikles i fremtidige prosjekter. 
            
            String.prototype.replaceAll = function (search, replacement) {
                var target = this;
                return target.split(search).join(replacement);
            };
            var x = 0;
            var base64 = "";
            function next() {
                var el = document.getElementById('geoListenerData');
                var content = el.innerHTML.replace(/  |^\s+|\s+$/g, "");
                var lines = content.split("</p>");
                var tabell = [];
                var string = "";
                for (var i = 0; i < lines.length - 1; i++) {
                    var tabell = lines[i].split("<p>");
                    for (var j = 1; j < 2; j++) {
                        string += tabell[j] + "|";
                    }
                }
                var newString = string.toString();
                var newString2 = newString.replaceAll("Add: ", "");
                var newString3 = newString2.replaceAll("Update: ", "");
                var newString4 = newString3.replace(/ /g, '');
                var newString5 = newString4.replaceAll("sek", "");
                newString5 = newString5.replace(/\\/g, '');
                newString5 = newString5.replaceAll(",", "");
                newString5 = newString5.replaceAll(";", "");
                var commandtabell = newString5.split("|");

                if (x > commandtabell.length-2) {
                    alert("Det ble ikke gjort flere endringer.");
                } else {
                    base64 = ggbApplet2.getBase64();
                    alert(commandtabell[x]);
                    ggbApplet2.evalCommand(commandtabell[x]);
                    x += 2;
                    
                }
            }

            function back() {
                var el = document.getElementById('geoListenerData');
                var content = el.innerHTML.replace(/  |^\s+|\s+$/g, "");
                var lines = content.split("</p>");
                var tabell = [];
                var string = "";
                for (var i = 0; i < lines.length - 1; i++) {
                    var tabell = lines[i].split("<p>");
                    for (var j = 1; j < 2; j++) {
                        string += tabell[j] + "|";
                    }
                }
                var newString = string.toString();
                var newString2 = newString.replaceAll("Add: ", "");
                var newString3 = newString2.replaceAll("Update: ", "");
                var newString4 = newString3.replace(/ /g, '');
                var newString5 = newString4.replaceAll("sek", "");
                var commandtabell = newString5.split("|");
                
                if (base64 != null && base64 != "") {
                    x -= 2;
                    ggbApplet2.evalCommand(commandtabell[x-2]);
                } else {
                    alert("Forrige endring eksisterer ikke.");
                }
                
            }
        </script>

        <script>
            var readyCheck = setInterval(function () {
                if (document.getElementById('hidden5')) {
                    var strInput = document.getElementById('hidden5').value;
                    ggbApplet.setBase64(strInput);
                    clearInterval(readyCheck);
                }
            }, 1);
        </script> 
        <script type="text/javascript">
            var cords = ${cords};
            var canvas, ctx,
                    prevX = 0,
                    currX = cords[0],
                    prevY = 0,
                    currY = cords[1];
            var counter = 2;
            var cont = false;
            var x = "black",
                    y = 4;
            function init() {
                canvas = document.getElementById('can');
                ctx = canvas.getContext("2d");
                w = canvas.width;
                h = canvas.height;
            }
            function nextStroke() {
                if ((counter - 2) < cords.length) {
                    cont = true;
                    findxy();
                } else {
                    return false;
                }
            }
            function draw() {
                ctx.beginPath();
                ctx.moveTo(prevX, prevY);
                ctx.lineTo(currX, currY);
                ctx.strokeStyle = x;
                ctx.lineWidth = y;
                ctx.stroke();
                ctx.closePath();
            }
            function erase() {
                ctx.clearRect(0, 0, w, h);
            }
            function findxy() {
                while (cont && (counter - 2) < cords.length) {
                    prevX = currX;
                    prevY = currY;
                    currX = cords[counter];
                    counter++;
                    currY = cords[counter];
                    counter++;
                    if (currX == -1.0 && (counter - 2) < cords.length) {
                        currX = cords[counter];
                        counter++;
                        currY = cords[counter];
                        counter++;
                        if (currX == -2.0 && (counter - 2) < cords.length) {
                            currX = cords[counter];
                            counter++;
                            currY = cords[counter];
                            counter++
                            erase();
                        }
                        cont = false;
                    } else if (currX == -2.0 && (counter - 2) < cords.length) {
                        currX = cords[counter];
                        counter++;
                        currY = cords[counter];
                        counter++;
                        erase();
                        cont = false;
                    } else {
                        draw();
                    }
                }
            }
        </script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    </body>
</html>
