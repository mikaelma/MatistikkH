<%-- 
    Document   : figurestask
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
        <title>Oppgave <c:out value = "${test.counter + 1}"/></title>
        <style>
            #numerator {
                width: 55px;
                height: 30px;
                padding:0; 
                margin:0 
            }
            #denominator{
                width: 55px;
                height: 30px;
                padding:0; 
                margin:0 
            }
            .container{
                height: 980px !important;
            
            }
            .panel-footer{
                height: 70px;
            }
            input::-webkit-outer-spin-button,
            input::-webkit-inner-spin-button {
                -webkit-appearance: none;
                margin: 0;
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
                    <div class="panel-heading">Oppgave <c:out value = "${test.counter + 1} av ${test.length}"/></div>
                    <div class="panel-body">
                        Oppgavetekst: 
                        
                            <img src="${test.currentTask.figureUrl}" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;"/>
                        <c:out value = "${test.currentTask}"/>
                        <hr>
                        Svar:
                        <center>
                        <div class="col-lg-12">
                            
                            <img src="<c:url value='/resources/images/figures/1div6.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setSelected('1div6A')" id="1div6A"/>
                            <img src="<c:url value='/resources/images/figures/1div5.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setSelected('1div5A')" id="1div5A"/>
                            <img src="<c:url value='/resources/images/figures/1div4.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setSelected('1div4A')" id="1div4A"/>
                            <img src="<c:url value='/resources/images/figures/1div3.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setSelected('1div3A')" id="1div3A"/>
                            <img src="<c:url value='/resources/images/figures/2div5.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setSelected('2div5A')" id="2div5A"/>
                            <img src="<c:url value='/resources/images/figures/1div2.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setSelected('1div2A')" id="1div2A"/>
                        <div class="col-lg-12">
                            <img src="<c:url value='/resources/images/figures/3div5.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setSelected('3div5A')" id="3div5A"/>
                            <img src="<c:url value='/resources/images/figures/2div3.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setSelected('2div3A')" id="2div3A"/>
                            <img src="<c:url value='/resources/images/figures/3div4.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setSelected('3div4A')" id="3div4A"/>
                            <img src="<c:url value='/resources/images/figures/4div5.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setSelected('4div5A')" id="4div5A"/>
                            <img src="<c:url value='/resources/images/figures/5div6.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setSelected('5div6A')" id="5div6A"/>
                            <img src="<c:url value='/resources/images/figures/2div2.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setSelected('2div2A')" id="2div2A"/>
                        </div>
                        
                        </center>
                        <center>
                        <span id="selectederror"></span>
                        </center>
                        Begrunnelse:
                        <textarea class="form-control" rows="4" id="comment" name="description" required="">${test.currentTask.answer.explenation}</textarea>
                        <hr>
                        Tegning:
                        <br>
                        <canvas id="can" width="600" height="200" style="border:1px solid #aaaaaa; background-color: white;"></canvas>
                        <br>
                        <button type="button" class="btn btn-primary" id="clr" size="23" onclick="erase()">Blankt</button>
                        </div>
                    <div class="panel-footer">
                        <nav>
                            <ul class="pager">
                                <c:if test = "${test.counter > 0}"><button type="submit" name="button" class="btn btn-default" id="prevTask" value="previous" onclick="previousTask()">Forrige</button></c:if>
                                <button type="submit" name="button" class="btn btn-success" id="submitAnswer" value="next" >Neste</button>
                                <input type="hidden" id="hidden1" name="answer">
                                <input type="hidden" id="coordinates" name="drawCords">
                            </ul>
                        </nav>
                    </div>
                </div>
            </form:form>
            
        </div>
        <script type="text/javascript">
            var selected = '';
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
            function setSelected(e){
                if(selected == ''){
                    document.getElementById(e).style.border = "medium solid #00FF00";
                }else{
                    document.getElementById(selected).style.border = "1px solid #aaaaaa";
                    document.getElementById(e).style.border = "medium solid #00FF00";
                }
                selected = e;
                document.getElementById("hidden1").value = selected;
            
            }
            function previousTask(){
                document.getElementById("numerator").removeAttribute("required");
                document.getElementById("denominator").removeAttribute("required");
                document.getElementById("comment").removeAttribute("required");
                selected = 'prev';
            }
            var url = "${test.currentTask.answer.value}";
            setSelected(url);
            
            
            if(${test.counter == test.length-1}){
                document.getElementById("submitAnswer").innerHTML = "Fullfør";
            }
            
        </script>
            
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    </body>
</html>
