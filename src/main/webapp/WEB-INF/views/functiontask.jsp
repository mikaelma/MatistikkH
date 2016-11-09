<%--
    Document   : functiontask
    Author     : Team 6
--%>
<!--Koden for tegneområdet er inspirert av: http://stackoverflow.com/questions/2368784/draw-on-html5-canvas-using-a-mouse/8398189#8398189 [Besøkt: 28.02.16] -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="no">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width= device-width, initial-scale = 1">
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
        <script type="text/javascript" src="https://www.geogebra.org/scripts/deployggb.js"></script>
        <script type="text/x-mathjax-config">MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}});</script>
        <script type="text/javascript" async  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML"></script>

        <title>Oppgave <c:out value = "${test.counter + 1}"/></title>
        <style>

            input::-webkit-outer-spin-button,
            input::-webkit-inner-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }

            .panel-footer{
                height: 70px;
            }
        </style>
    </head>
    <body onload="fillOptions(), init()">
        <jsp:include page="/WEB-INF/views/menu.jsp"/>
        <jsp:include page="/WEB-INF/views/styling.jsp"/>
        <div class="container">
            <br><br>
            <form:form action="nexttask" method="POST" modelAttribute="test">
                <div class="panel panel-default">
                    <div class="panel-heading">Oppgave <c:out value = "${test.counter + 1} av ${test.length}"/></div>
                    <div class="panel-body">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 class="panel-title">Oppgave</h3>
                            </div>
                            <div class="panel-body">
                                ${test.currentTask}
                            </div>
                        </div>
                        <div class="panel panel-success">
                            <div class="panel-heading">
                                <h3 class="panel-title">Svar</h3>
                            </div>
                            <div class="panel-body">
                                <c:if test = "${answertype == 1}">
                                    <c:if test = "${functionstring != 'tom'}">
                                        <div class="panel panel-warning">
                                            <div class="panel-heading">
                                                <h3 class="panel-title">Geogebra</h3>
                                            </div>
                                            <div class="panel-body">
                                                <div id="applet_container"></div>
                                            </div>
                                        </div>

                                    </c:if>

                                    <div class="panel panel-warning">
                                        <div class="panel-heading">
                                            <h3 class="panel-title">Tekstsvar</h3>
                                        </div>
                                        <div class="panel-body"> 
                                            <textarea class="form-control" rows="4" name="answer" id="tt" autofocus required></textarea>
                                        </div>
                                    </div>
                                </c:if>

                                <c:if test = "${answertype == 2}">
                                    <input type="hidden" id="hidden1" name="antall" value="${amount}">
                                    <c:if test = "${functionstring != 'tom'}">
                                        <div class="panel panel-warning">
                                            <div class="panel-heading">
                                                <h3 class="panel-title">Geogebra</h3>
                                            </div>
                                            <div class="panel-body">
                                                <div id="applet_container"></div>
                                            </div>
                                        </div>
                                    </c:if>

                                    <div class="panel panel-warning">
                                        <div class="panel-heading">
                                            <h3 class="panel-title">Svaralternativer</h3>
                                        </div>
                                        <div class="panel-body"> 
                                            <div id="options">
                                                <input type="radio" name="options" onClick="setText(this)" value="${option1}">${option1}<br> 
                                                <input type="radio" name="options" onClick="setText(this)" value="${option2}">${option2}<br>
                                            </div>
                                        </div>
                                    </div>
                                    <input type="hidden" id="hidden2" name="optionAnswer">
                                </c:if>

                                <c:if test = "${answertype == 3}">
                                    <c:if test = "${functionstring != 'tom'}">
                                        <div class="panel panel-warning">
                                            <div class="panel-heading">
                                                <h3 class="panel-title">Geogebra</h3>
                                            </div>
                                            <div class="panel-body">
                                                <div id="applet_container"></div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:if>

                                <c:if test="${checkExplanation}">
                                    <div class="panel panel-warning">
                                        <div class="panel-heading">
                                            <h3 class="panel-title">Begrunnelse</h3>
                                        </div>
                                        <div class="panel-body">                                     
                                            <textarea class="form-control" rows="4" id="comment" name="description" style="resize: none;" required=""></textarea>
                                        </div>
                                    </div>
                                </c:if>

                                <c:if test="${checkDrawing}">
                                    <div class="panel panel-warning">
                                        <div class="panel-heading">
                                            <h3 class="panel-title">Tegning</h3>
                                        </div>
                                        <div class="panel-body"> 
                                            <canvas id="can" width="600" height="300" style="border:1px solid #aaaaaa; background-color: white;"></canvas>
                                            <br>
                                            <button type="button" name = "clear" id="clr" onclick="erase()">Blankt</button>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <div class="panel-footer">
                        <nav>
                            <div class="pager">
                                <c:if test = "${test.counter > 0}">
                                    <button type="submit" name="button" class="btn btn-default" id="prevTask" value="previous" onclick="previousTask();">Forrige</button>
                                </c:if>
                                <button type="submit" name="button" class="btn btn-success" onclick="putBase64(); updateUpdate(); setGeoText();" id="submitAnswer" value="next">Neste</button>
                                <input type="hidden" id="coordinates" name="drawCords">
                                <input type="hidden" name="inputField" id="functionstring" value="${functionstring}">
                                <input type="hidden" name="base64String" id="hidden3">
                                <input type="hidden" id="hidden4">
                                <textarea rows="8" id="geooutput" style="display: none"></textarea>
                                <textarea rows="8" id="updateoutput" style="display: none"></textarea>
                                <input type="hidden" id="updatetext" name="geolistener">
                            </div>
                        </nav>
                    </div>
                </div>
            </form:form>
        </div>

        <script type="text/javascript">
            var parameters = {"prerelease": false, "width": 800, "height": 600, "borderColor": null, "showToolBar": true, "showMenuBar": false, "showAlgebraInput": false,
                "showResetIcon": false, "enableLabelDrags": false, "enableShiftDragZoom": true, "enableRightClick": false, "capturingThreshold": null, "showToolBarHelp": false,
                "errorDialogsActive": true, "useBrowserForJS": true, "enableCAS": true};

            var applet = new GGBApplet('5.0', parameters);

            applet.setJavaCodebase('GeoGebra/Java/5.0');

            window.onload = function () {
                applet.inject('applet_container', 'preferHTML5');
            };
        </script>   
        <script>
            function ggbOnInit() {
                // register add, remove, rename and update listeners
                var d = new Date();
                var n = d.getTime();
                document.getElementById('hidden4').value = n;
                var applet = document.ggbApplet;
                applet.registerAddListener("addListener");
                applet.registerRemoveListener("removeListener");
                applet.registerRenameListener("renameListener");
                applet.registerClearListener("clearListener");
                applet.registerUpdateListener("updateListener");
            }
            function addListener(objName) {
                var d = new Date();
                var n = document.getElementById('hidden4').value;
                var k = (d.getTime() - n) / 1000;
                var strVal = document.ggbApplet.getValueString(objName);
                document.getElementById('geooutput').value += "Add: " + strVal + " | " + k + "\n";
            }
            function removeListener(objName) {
                var d = new Date();
                var n = document.getElementById('hidden4').value;
                var k = (d.getTime() - n) / 1000;
                document.getElementById('geooutput').value += "Remove: " + objName + " | " + k + "\n";
            }

            function updateListener(objName) {
                var d = new Date();
                var n = document.getElementById('hidden4').value;
                var k = (d.getTime() - n) / 1000;
                var strVal = document.ggbApplet.getValueString(objName);

                document.getElementById('updateoutput').value += "Update: " + strVal + " | " + k + "\n";
            }

        </script>      
        <script>
            var readyCheck = setInterval(function () {
                if (document.getElementById('functionstring')) {
                    var strInput = document.getElementById('functionstring').value;
                    ggbApplet.setBase64(strInput);
                    clearInterval(readyCheck);
                }
            }, 1);
        </script>
        <script>
            function updateUpdate() {
                var field = document.getElementById('updateoutput').value;
                var updatefield = document.getElementById('geooutput');
                var lines = field.split('\n');
                var linje = [];

                for (var i = 0; i < lines.length; i++) {
                    var str = lines[i];
                    var nystr = str.substring(str.indexOf("|") + 1);
                    linje[i] = nystr;
                }

                for (var k = 0; k < linje.length; k++) {
                    var h = parseFloat(linje[k]);
                    var s = parseFloat(linje[k + 1]);
                    if (h + 0.3 < s) {
                        updatefield.value += lines[k] + "\n";
                    }
                    if (k == (linje.length - 1)) {
                        updatefield.value += lines[k - 1];
                    }
                }
            }
        </script>
        <script>
            function setGeoText() {
                var valuefield = document.getElementById('geooutput').value;
                var lines = valuefield.split('\n');
                var textfield = document.getElementById('updatetext');

                for (var i = 0; i < lines.length; i++) {
                    if (i == (lines.length - 1)) {
                        textfield.value += lines[i];
                    } else {
                        textfield.value += lines[i] + "|||";
                    }
                }
            }
        </script>
        <script>
            function putBase64() {
                var geoString = ggbApplet.getBase64();
                document.getElementById('hidden3').value = geoString;
            }
        </script>

        <script type="text/javascript">
            var readyCheck1 = setInterval(function () {
                if (document.getElementById('options')) {
                    var amount = document.getElementById("hidden1").value;

                    if (amount == 3) {
                        document.getElementById("options").innerHTML += '<input type="radio" name="options" onClick="setText(this)" value="${option3}">${option3}<br>';
                    }
                    if (amount == 4) {
                        document.getElementById("options").innerHTML += '<input type="radio" name="options" onClick="setText(this)" value="${option3}">${option3}<br>';
                        document.getElementById("options").innerHTML += '<input type="radio" name="options" onClick="setText(this)" value="${option4}">${option4}<br>';
                    }
                    if (amount == 5) {
                        document.getElementById("options").innerHTML += '<input type="radio" name="options" onClick="setText(this)" value="${option3}">${option3}<br>';
                        document.getElementById("options").innerHTML += '<input type="radio" name="options" onClick="setText(this)" value="${option4}">${option4}<br>';
                        document.getElementById("options").innerHTML += '<input type="radio" name="options" onClick="setText(this)" value="${option5}">${option5}<br>';
                    }
                    if (amount == 6) {
                        document.getElementById("options").innerHTML += '<input type="radio" name="options" onClick="setText(this)" value="${option3}">${option3}<br>';
                        document.getElementById("options").innerHTML += '<input type="radio" name="options" onClick="setText(this)" value="${option4}">${option4}<br>';
                        document.getElementById("options").innerHTML += '<input type="radio" name="options" onClick="setText(this)" value="${option5}">${option5}<br>';
                        document.getElementById("options").innerHTML += '<input type="radio" name="options" onClick="setText(this)" value="${option6}">${option6}<br>';
                    }
                    if (amount == 7) {
                        document.getElementById("options").innerHTML += '<input type="radio" name="options" onClick="setText(this)" value="${option3}">${option3}<br>';
                        document.getElementById("options").innerHTML += '<input type="radio" name="options" onClick="setText(this)" value="${option4}">${option4}<br>';
                        document.getElementById("options").innerHTML += '<input type="radio" name="options" onClick="setText(this)" value="${option5}">${option5}<br>';
                        document.getElementById("options").innerHTML += '<input type="radio" name="options" onClick="setText(this)" value="${option6}">${option6}<br>';
                        document.getElementById("options").innerHTML += '<input type="radio" name="options" onClick="setText(this)" value="${option7}">${option7}<br>';
                    }
                    if (amount == 8) {
                        document.getElementById("options").innerHTML += '<input type="radio" name="options" onClick="setText(this)" value="${option3}">${option3}<br>';
                        document.getElementById("options").innerHTML += '<input type="radio" name="options" onClick="setText(this)" value="${option4}">${option4}<br>';
                        document.getElementById("options").innerHTML += '<input type="radio" name="options" onClick="setText(this)" value="${option5}">${option5}<br>';
                        document.getElementById("options").innerHTML += '<input type="radio" name="options" onClick="setText(this)" value="${option6}">${option6}<br>';
                        document.getElementById("options").innerHTML += '<input type="radio" name="options" onClick="setText(this)" value="${option7}">${option7}<br>';
                        document.getElementById("options").innerHTML += '<input type="radio" name="options" onClick="setText(this)" value="${option8}">${option8}<br>';
                    }
                    if (amount == 9) {
                        document.getElementById("options").innerHTML += '<input type="radio" name="options" onClick="setText(this)" value="${option3}">${option3}<br>';
                        document.getElementById("options").innerHTML += '<input type="radio" name="options" onClick="setText(this)" value="${option4}">${option4}<br>';
                        document.getElementById("options").innerHTML += '<input type="radio" name="options" onClick="setText(this)" value="${option5}">${option5}<br>';
                        document.getElementById("options").innerHTML += '<input type="radio" name="options" onClick="setText(this)" value="${option6}">${option6}<br>';
                        document.getElementById("options").innerHTML += '<input type="radio" name="options" onClick="setText(this)" value="${option7}">${option7}<br>';
                        document.getElementById("options").innerHTML += '<input type="radio" name="options" onClick="setText(this)" value="${option8}">${option8}<br>';
                        document.getElementById("options").innerHTML += '<input type="radio" name="options" onClick="setText(this)" value="${option9}">${option9}<br>';
                    }
                    clearInterval(readyCheck1);
                }
            }, 1);
        </script>

        <script type="text/javascript">
            var canvas, ctx, flag = false,
                    prevX = 0,
                    currX = 0,
                    prevY = 0,
                    currY = 0,
                    dot_flag = false;
            var cords = [];
            var x = "black",
                    y = 4;

            var tempX, tempY = 0;

            function init() {
                canvas = document.getElementById('can');
                ctx = canvas.getContext("2d");
                w = canvas.width;
                h = canvas.height;

                canvas.addEventListener("mousemove", function (e) {
                    findxy('move', e);
                }, false);
                canvas.addEventListener("mousedown", function (e) {
                    findxy('down', e);
                }, false);
                canvas.addEventListener("mouseup", function (e) {
                    findxy('up', e);
                }, false);
                canvas.addEventListener("mouseout", function (e) {
                    findxy('out', e);
                }, false);
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
                cords.push('-2.0,-2.0');

            }
            function findxy(res, e) {
                if (res == 'down') {
                    prevX = currX;
                    prevY = currY;
                    currX = e.clientX - canvas.offsetLeft;
                    currY = e.clientY - canvas.offsetTop;
                    tempX = currX;
                    tempY = currY;
                    if (Math.abs(currX - prevX) >= 4.0 || Math.abs(currY - prevY) >= 4.0) {
                        cords.push(currX + ',' + currY);
                    }
                    flag = true;
                    dot_flag = true;
                    if (dot_flag) {
                        ctx.beginPath();
                        ctx.fillStyle = x;
                        ctx.fillRect(currX, currY, 2, 2);
                        ctx.closePath();
                        dot_flag = false;
                    }
                }
                if (res == 'up' || res == 'out') {
                    if (tempX != -1.0 && tempY != -1.0) {
                        tempX = e.clientX - canvas.offsetLeft;
                        tempY = e.clientY - canvas.offsetTop;
                        if (tempX >= 0 && tempX <= 600 && tempY >= 0 && tempY <= 300 && prevX) {
                            cords.push("-1.0,-1.0");
                            document.getElementById("coordinates").value = cords;
                            tempX = -1.0;
                            tempY = -1.0;
                        }
                    }
                    flag = false;
                }
                if (res == 'move') {
                    if (flag) {
                        prevX = currX;
                        prevY = currY;
                        currX = e.clientX - canvas.offsetLeft;
                        currY = e.clientY - canvas.offsetTop;
                        cords.push(currX + ',' + currY);
                        draw();
                    }
                }
            }


            function previousTask() {
                document.getElementById("numerator").removeAttribute("required");
                document.getElementById("denominator").removeAttribute("required");
                document.getElementById("comment").removeAttribute("required");
            }

            if (${test.counter == test.length-1}) {
                document.getElementById("submitAnswer").innerHTML = "Fullfør";
            }
        </script>
        <script>
            function setText(obj) {
                document.getElementById('hidden2').value = obj.value;
            }
        </script>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    </body>
</html>