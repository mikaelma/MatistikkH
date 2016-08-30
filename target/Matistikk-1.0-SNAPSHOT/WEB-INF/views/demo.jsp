<%-- 
    Document   : demo
    Author     : Team ENMAKA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width= device-witdh, initial-scale = 1">
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"> 
        <title>Om Matistikk</title>
    </head>
    <body onload="init()">
        <jsp:include page="/WEB-INF/views/styling.jsp"/>
   <jsp:include page="/WEB-INF/views/menu.jsp" />
        <div class="container">
            <div class="page-header">
                    <center><h1>Tegnedemo</h1></center>
                </div>
            <div class="jumbotron ">
                
                    </div>
                        <div id ="drawing">
                        <canvas id="can" width="600" height="300" style="border:1px solid #aaaaaa; background-color: white;"></canvas>
                        <img id="canvasimg" style="position:absolute;top:10%;left:52%;" style="display:none;">
                        </div>
            <button type ="button" onclick="nextStroke()">Neste</button>
            <input type="hidden" id="hidden1">
            <input type="hidden" id="hidden2">
            </div>
        </div>
    </body>
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
                    
                    if((currX == -1.0 || prevX == -1.0) && (counter-2) <cords.length){
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
</html> 
