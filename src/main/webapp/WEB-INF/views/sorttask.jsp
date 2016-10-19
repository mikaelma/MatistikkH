<%-- 
    Document   : sorttask
    Author     : Team ENMAKA
--%>
<!--Koden for drag and drop-elementene på denne siden er hentet fra http://www.html5rocks.com/en/tutorials/dnd/basics/ [Besøkt: 03.02.16]-->

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
        <title>Oppgave <c:out value="${test.counter + 1}"/></title>
        <style>
        .container{
           height: auto !important;
            
        }
        .panel-footer{
           height: 70px;
        }
        [draggable] {
          -moz-user-select: none;
          -khtml-user-select: none;
          -webkit-user-select: none;
          user-select: none;
          -khtml-user-drag: element;
          -webkit-user-drag: element;
        }
        .fraction {
          float: left;
          border: 3px solid #666666;
          margin-right: 5px;
          text-align: center;
          cursor: move;
          height: 100px;
          width: 100px;
          font-size: 50px;
          text-shadow: #000 0 1px;
          padding: 10px;
        }
        br{
            clear:both;
        }
        </style>
    </head>
    <body onload="init()">
        <jsp:include page="/WEB-INF/views/menu.jsp"/>
        <jsp:include page="/WEB-INF/views/styling.jsp"/>
        <div class="container">
            <br><br>
            <form:form action="nexttask" method="POST" modelAttribute="test">
                <div class="panel panel-default">
                    <div class="panel-heading">Oppgave <c:out value="${test.counter + 1} av ${test.length}"/></div>
                    <div class="panel-body">
                        Oppgavetekst: <c:out value="${test.currentTask}"/>
                        <hr>
                        Dra brøkene i riktig rekkefølge.
                        <br><br>
                        Svar:
                        <div id = "fractions">
                        <c:forEach var="fraction" items="${test.currentTask.fractions}" varStatus="status">
                            <div class="fraction" id="fraction${status.index}" draggable="true"><c:out value="${fraction.toString()}"/></div>
                        </c:forEach>
                        </div>
                        <br><br>
                        Begrunnelse:
                        <textarea class="form-control" rows="4" id="comment" required><c:out value="${test.currentTask.answer.explenation}"/></textarea>
                        <hr>
                        Tegning:
                        <br>
                        <canvas id="can" width="600" height="300" style="border:1px solid #aaaaaa; background-color: white;"></canvas>
                        <br>
                        <button type="button" class="btn btn-primary" id="clr" size="23" onclick="erase()">Blankt</button>
                        </div>
                    <div class="panel-footer">
                        <nav>
                            <ul class="pager">
                                <c:if test = "${test.counter > 0}"><button type="submit" name="button" class="btn btn-default" id="prevTask" value="previous" onclick="previousTask()">Forrige</button></c:if>
                                <button type="submit" name="button" class="btn btn-success" id="submitAnswer" onclick="setAnswer()" value="next" >Neste</button>
                                <input type="hidden" id="hidden1" name="answer">
                                <input type="hidden" id="hidden2" name="description">
                                <input type="hidden" id="coordinates" name="drawCords">
                            </ul>
                        </nav>
                    </div>
                </div>
            </form:form>
            <script>
            var fractions = document.querySelectorAll('#fractions .fraction');
            var dragElement = null;
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

            function init(){
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
            
            this.handleDragStart = function(element) {
                element.dataTransfer.effectAllowed = 'move';
                element.dataTransfer.setData('text/html', this.innerHTML);

                  dragElement = this;

                  this.style.opacity = '0.6';
                };

                this.handleDragOver = function(element) {
                  if (element.preventDefault) {
                    element.preventDefault();
                  }

                  element.dataTransfer.dropEffect = 'move';

                  return false;
                };

                this.handleDragEnter = function(element) {
                };

                this.handleDragLeave = function(element) {
                };

                this.handleDrop = function(element) {
                  if (element.stopPropagation) {
                    element.stopPropagation();
                  }

                  if (dragElement != this) {
                    dragElement.innerHTML = this.innerHTML;
                    this.innerHTML = element.dataTransfer.getData('text/html');
                  }

                  return false;
                };

                this.handleDragEnd = function(element) {
                  this.style.opacity = '1';

                  [].forEach.call(fractions, function (frac) {
                  });
                };

                [].forEach.call(fractions, function (frac) {
                  frac.setAttribute('draggable', 'true');
                  frac.addEventListener('dragstart', this.handleDragStart, false);
                  frac.addEventListener('dragenter', this.handleDragEnter, false);
                  frac.addEventListener('dragover', this.handleDragOver, false);
                  frac.addEventListener('dragleave', this.handleDragLeave, false);
                  frac.addEventListener('drop', this.handleDrop, false);
                  frac.addEventListener('dragend', this.handleDragEnd, false);
                });
            
            function setAnswer(){
                var fs = document.getElementById("fraction0").textContent;
                for(i = 1; i < ${test.currentTask.length}; i++){
                    fs += "|" + document.getElementById("fraction" + i).textContent;
                }
                document.getElementById("hidden1").value = fs;
                document.getElementById("hidden2").value = document.getElementById("comment").value;
            
            }
            function previousTask(choices){
                document.getElementById("comment").removeAttribute("required");
                for(i = 0; i<choices; i++){
                    document.getElementById("fraction" + i).removeAttribute("required");
                }
            }
            
            if(${test.counter == test.length-1}){
                document.getElementById("submitAnswer").innerHTML = "Fullfør";
            }
            
           var fractions = "${test.currentTask.answer.fractionString}";
            if(fractions !== ""){
                var s = fractions.split('|');
                for(i = 0; i<parseInt("${test.currentTask.answer.length}"); i++){
                    document.getElementById("fraction"+i).textContent = s[i];
                }
            }
        </script>
        </div>
        
            
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    </body>
</html>
