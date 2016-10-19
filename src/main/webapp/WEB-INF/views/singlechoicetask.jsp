<%-- 
    Document   : singlechoicetask
    Author     : Team ENMAKA
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
        <title>Oppgave <c:out value="${test.counter + 1}"/></title>
        <style>
            #buttons{
                font-size: 140%;
            }
            .container{
                height: 850px !important;
            
            }
            .panel-footer{
                height: 70px;
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
                        Svar:
                        <div id = "buttons">
                        <c:forEach var="fraction" items="${test.currentTask.choices}" varStatus="status">
                            <input type="radio" name="answer" value="${fraction}" id="fraction${status.index}" required><c:out value="${fraction.toString()}"/> 
                        </c:forEach>
                        </div>
                        <br>
                        Begrunnelse:
                        <textarea class="form-control" rows="4" id="comment" name="description" required=""><c:out value="${test.currentTask.answer.explenation}"/></textarea>
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
                                <button type="submit" name="button" class="btn btn-success" id="submitAnswer" value="next">Neste</button>
                                <input type="hidden" id="coordinates" name="drawCords">
                            </ul>
                        </nav>
                    </div>
                </div>
            </form:form>
            <script>var canvas, ctx, flag = false,
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
                        tempX = currX;
                        tempY = currY;
                        draw();
                    }
                }
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
            
        </script>
        </div>
        
            
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    </body>
</html>
