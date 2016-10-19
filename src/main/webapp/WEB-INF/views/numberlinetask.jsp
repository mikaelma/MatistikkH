<%-- 
    Document   : numberlinetask
    Author     : Team ENMAKA
--%>
<!--Koden for tallinje er utvidet fra eksempelet: http://jsbin.com/itino4/127/edit?html,js,output [Besøkt: 14.02.16] -->
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
        <script src="//code.jquery.com/jquery-1.12.3.min.js"></script>
        <title>Oppgave <c:out value="${test.counter + 1}"/></title>
        <style>
            #stepNumber {
                width: 30px;
                height: 30px;
                padding:0; 
                margin:0 
            }
            input::-webkit-outer-spin-button,
            input::-webkit-inner-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }
            .container{
                height: auto !important;
            
            }
            .panel-footer{
                height: 70px;
            }
        </style>
    </head>
    <body onload="drawInit()">
        <jsp:include page="/WEB-INF/views/menu.jsp"/>
        <jsp:include page="/WEB-INF/views/styling.jsp"/>
        <div class="container">
            <br><br>
            <form:form action="nexttask" method="POST" modelAttribute="test">
                <div class="panel panel-default">
                    <div class="panel-heading">Oppgave <c:out value = "${test.counter + 1} av ${test.length}"/></div>
                    <div class="panel-body">
                        Oppgavetekst: <c:out value = "${test.currentTask}"/>
                        <hr>
                        Svar:
                        <br>
                        Antall divisjoner:
                        <input type="number" id="stepNumber" value="${test.currentTask.answer.value.denominator}" autofocus required>
                        <br>
                        <canvas id="canvas"></canvas>
                        <br>
                        Begrunnelse:
                        <textarea class="form-control" rows="4" id="comment" name="description" required=""><c:out value="${test.currentTask.answer.explenation}"/></textarea>
                        
                        <hr>
                        Tegning:
                        <br>
                        <canvas id="can" width="600" height="200" style="border:1px solid #aaaaaa; background-color: white;"></canvas>
                        <br>
                        <button type="button" class="btn btn-primary" id="clr" size="23" onclick="erase()">Blankt</button>
                        </div>
                        
                    </div>
                    <div class="panel-footer">
                        <nav>
                            <ul class="pager">
                                <c:if test = "${test.counter > 0}"><button type="submit" name="button" class="btn btn-default" id="prevTask" value="previous" onclick="previousTask()">Forrige</button></c:if>
                                <button type="submit" name="button" class="btn btn-success" id="submitAnswer" value="next" >Neste</button>
                                <input type="hidden" id="hidden1" name="answer" value="${test.currentTask.answer.value}">
                                <input type="hidden" id="coordinates" name="drawCords">
                            </ul>
                        </nav>
                    </div>
                </div>
            </form:form>
        </div>
        <script type="text/javascript">
            
            $(function() {
                var canvas = $('canvas')[0];
                var ctx = canvas.getContext('2d');
                var stepNumber = document.getElementById('stepNumber');
                var w = canvas.width = 700;
                var h = canvas.height = 100;
                var starti=0;
                var endi=1;
                var interval =500;
                var steps = 1;
                var selectedStep = "${test.currentTask.answer.value}";
               
                
                stepNumber.oninput = function(){
                    setSteps(stepNumber.value);
                    init();
                };
                
                stepNumber.onpropertychange = stepNumber.oninput;
                canvas.addEventListener("mousedown", getPosition, false);
                
                function drawPoint(x1){
                    ctx.beginPath();
                    ctx.arc(x1,h/2,3,0,2*Math.PI);
                    ctx.fillStyle = '#f00';
                    ctx.strokeStyle = '#f00';
                    ctx.fill();
                    ctx.stroke();
                }
                
                function setSteps(s){
                    steps = s;
                }

                function getPosition(e){
                  var x = e.clientX-canvas.offsetLeft;
                  var xe;
                  var diff1 = Math.abs(x-(w/7));
                  for(i = 0; i <= steps; i++){
                    var diff2 = Math.abs(x - (w/7 + (i/steps) * interval));
                    if(diff2 <= diff1){
                      diff1 = diff2;
                      xe = w/7 + (i/steps) * interval;
                      selectedStep = i + "/" + steps;
                    }
                  }
                  init();
                  drawPoint(xe);
                  document.getElementById("hidden1").value = selectedStep;
                } 
                
                function init(){
                  ctx.fillStyle = '#FFFFFF';
                  ctx.fillRect(0, 0, w, h);
                  ctx.fill();
                  ctx.beginPath();
                  ctx.lineWidth = 2;
                  ctx.strokeStyle = '#000';
                  ctx.moveTo(w/7, h/2);
                  ctx.lineTo(6*w/7, h/2);
                  ctx.stroke();
                  for(var i = starti;i <= endi; i++) {
                    ctx.beginPath();
                    ctx.strokeStyle = '#000';
                    ctx.lineWidth = 3;
                    ctx.moveTo(w/7 + i * interval, h/2 - 10);
                    ctx.lineTo(w/7 + i * interval, h/2 + 10);
                    ctx.fillStyle = '#000';
                    ctx.fillText(i, (w/7 + i * interval )- 5, h/2 + 25);
                    ctx.fill();
                    ctx.stroke();
                  }for(var j = 0; j<steps; j++){
                    ctx.beginPath();
                    ctx.strokeStyle = '#000';
                    ctx.lineWidth = 2;
                    ctx.moveTo(w/7 + (j/steps) * interval, h/2 - 10);
                    ctx.lineTo(w/7 + (j/steps) * interval, h/2 + 10);
                    ctx.fillStyle = '#000';
                    ctx.fill();
                    ctx.stroke();
                  }

                }
                
                init();
                
                if(selectedStep !== ""){
                    steps = parseInt("${test.currentTask.answer.value.denominator}");
                    var xe = w/7 + (parseInt("${test.currentTask.answer.value.numerator}")/steps) * interval;
                    init();
                    drawPoint(xe);
                    document.getElementById("hidden1").value = selectedStep;
                    
                }
                
                
              });
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

            function drawInit(){
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
                    if(Math.abs(currX-prevX) >= 4.0 || Math.abs(currY-prevY) >= 4.0 ){
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
                    if(tempX != -1.0 && tempY != -1.0){
                        tempX = e.clientX-canvas.offsetLeft;
                        tempY = e.clientY-canvas.offsetTop;
                        if(tempX >= 0 && tempX <= 600 && tempY >= 0 && tempY <= 300 && prevX){
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
            function previousTask(){
                document.getElementById("stepNumber").removeAttribute("required");
                document.getElementById("comment").removeAttribute("required");
            }
            if(${test.counter == test.length-1}){
                document.getElementById("submitAnswer").innerHTML = "Fullfør";
            }
        </script>
            
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    </body>
</html>
