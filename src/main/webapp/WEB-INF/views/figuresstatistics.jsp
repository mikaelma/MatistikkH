<%-- 
    Document   : figuresstatistics
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
        <title>Figures</title>
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
                <h4>Besvarelse av oppgave ${answer.taskId}</h4>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    Oppgave <c:out value="${answer.taskId}" /> 
                </div>
                <div class="panel-body">
                    
                <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                    <p>Svar</p>
                    <c:if test="${answer.value == '1div6A'}"><img src="<c:url value='/resources/images/figures/1div6.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;"/></c:if>
                    <c:if test="${answer.value == '1div5A'}"><img src="<c:url value='/resources/images/figures/1div5.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;"/></c:if>
                    <c:if test="${answer.value == '1div4A'}"><img src="<c:url value='/resources/images/figures/1div4.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;"/></c:if>
                    <c:if test="${answer.value == '1div3A'}"><img src="<c:url value='/resources/images/figures/1div3.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;"/></c:if>
                    <c:if test="${answer.value == '2div5A'}"><img src="<c:url value='/resources/images/figures/2div5.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;"/></c:if>
                    <c:if test="${answer.value == '1div2A'}"><img src="<c:url value='/resources/images/figures/1div2.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;"/></c:if>
                    <c:if test="${answer.value == '3div5A'}"><img src="<c:url value='/resources/images/figures/3div5.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;"/></c:if>
                    <c:if test="${answer.value == '2div3A'}"><img src="<c:url value='/resources/images/figures/2div3.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;"/></c:if>
                    <c:if test="${answer.value == '3div4A'}"><img src="<c:url value='/resources/images/figures/3div4.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;"/></c:if>
                    <c:if test="${answer.value == '4div5A'}"><img src="<c:url value='/resources/images/figures/4div5.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;"/></c:if>
                    <c:if test="${answer.value == '5div6A'}"><img src="<c:url value='/resources/images/figures/5div6.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;"/></c:if>
                    <c:if test="${answer.value == '2div2A'}"><img src="<c:url value='/resources/images/figures/2div2.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;"/></c:if>
                    <hr>
                    <label><u>Riktig/Galt</u></label>
                        <p><c:out value="${answer.correct ? 'Riktig' : 'Galt'}"/></p>
                    <hr>
                        <label><u>Tid brukt</u></label>
                        <p><c:out value="${answer.time}"/></p>
                    <hr>
                    <p><strong><u>Forklaring/begrunnelse</u></strong></p>
                    <p><c:out value="${answer.explenation}"/></p>
                </div>
                    <p>Tegning</p>
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
                <br>
                    
                </div>
            </div>
                
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    </body>
</html>
