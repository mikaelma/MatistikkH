<%-- 
    Document   : numberline
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
            
            input::-webkit-outer-spin-button,
            input::-webkit-inner-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }
        </style>
        <title>Tallinje oppgave</title>
    </head>
    <body>
        <jsp:include page="/WEB-INF/views/menu.jsp"/>
        <jsp:include page="/WEB-INF/views/styling.jsp"/>
        <div class="container">
            <div class="jumbotron">
                <div class="page-header">
                    <p class="text-center">Oppgave av typen Tallinje</p>
                </div>
                <form:form action="addnumberlinetask" method="POST" modelAttribute="numberline">
                    <div class="form-group" id="fields" style="height: 380px; overflow-y: auto;">
                        <span id="question1">Plasser</span>
                        <input type="number" name="numerator" id="numerator" placeholder="Teller" autofocus required> /
                        <input type="number" name="denominator" id="denominator" placeholder="Nevner" required>
                        <span id="question2">på tallinjen.</span>
                    </div>
                    <a class="btn btn-primary" href="createtaskview">Tilbake</a>
                    <button type="submit" class="btn btn-success" onclick="setText()">Legg til</button>
                    <input type="hidden" id="hidden1" name="text">
                </form:form>
            </div>
        </div>
        <script>
                function setText() {
                    document.getElementById("hidden1").value = document.getElementById('question1').innerHTML + ' ' + document.getElementById('numerator').value + '/' + document.getElementById('denominator').value + ' ' + document.getElementById('question2').innerHTML;
                }
            </script>
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    </body>
</html>
