<%-- 
    Document   : singlechoicestatistics
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
        <title>Single Choice</title>
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
                    <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                        <div class="form-group">
                            <label><u>Svar</u></label>
                            <p><c:out value="${answer.value.numerator}"/>/<c:out value="${answer.value.denominator}"/></p>    
                            <hr>
                            <label><u>Riktig/Galt</u></label>
                            <p><c:out value="${answer.correct ? 'Riktig' : 'Galt'}"/></p>
                            <hr>
                            <label><u>Tid brukt</u></label>
                            <p><c:out value="${answer.time}"/></p>
                            <hr>
                            <label><u>Forklaring/begrunnelse</u></label>
                            <p><c:out value="${answer.explenation}"/></p>
                        </div>
                    </div>
                    <div class="col-lg-8 col-md-8 col-sm-12 col-xs-12">
                        <div id ="drawing">
                            <canvas id="can" width="600" height="300" style="border:1px solid #aaaaaa; background-color: white;"></canvas>
                            <img id="canvasimg" style="position:absolute;top:10%;left:52%;" style="display:none;">
                        </div>
                        <button type ="button" onclick="nextStroke()">Neste</button>
                        <input type="hidden" id="hidden1">
                        <input type="hidden" id="hidden2">
                    </div>
                </div>
            <form:form action="taskstatistics" method="POST">
                <input type="hidden" name="testId" value="${testId}">
                <input type="hidden" name="taskId" value="${answer.taskId}">
                <button type="submit" class="btn btn-primary">Tilbake</button>
            </form:form>
            </div>
        </div>
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
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
            function nextStroke(){
                if((counter-2) < cords.length){
                    cont = true;
                    findxy();
                }else{
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
                while(cont && (counter-2) < cords.length){
                    prevX = currX;
                    prevY = currY;
                    currX = cords[counter];
                    counter++;
                    currY = cords[counter];
                    counter++;
                    
                    
                    if(currX == -1.0 && (counter-2) <cords.length){
                        currX = cords[counter];
                        counter++;
                        currY = cords[counter];
                        counter++;
                        if(currX == -2.0 && (counter-2) <cords.length){
                            currX = cords[counter];
                            counter++;
                            currY = cords[counter];
                            counter++
                            erase();
                        }
                        cont = false;
                    }else if(currX == -2.0 && (counter-2) <cords.length){
                        currX = cords[counter];
                        counter++;
                        currY = cords[counter];
                        counter++;
                        erase();
                        cont = false;
                    }else{
                        draw();
                    }
                }
            }
    </script>
    </body>
</html>
