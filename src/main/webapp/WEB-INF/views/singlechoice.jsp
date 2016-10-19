<%-- 
    Document   : singlechoice
    Author     : Team ENMAKA
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html lang="no">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width= device-witdh, initial-scale = 1">
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"> 
        <title>"Velg riktig" oppgave</title>
        <style>
            .form-control {
                width: 20%;
            }
            .modal-backdrop{
                z-index: 0;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/WEB-INF/views/menu.jsp"/>
        <jsp:include page="/WEB-INF/views/styling.jsp"/>
        <div class="container">
            <div class="jumbotron">
                <div class="page-header">
                    <p class="text-center">Oppgave av typen "Velg riktig"</p>
                </div>
                <form:form action="addsinglechoicetask" method="POST" modelAttribute="singleChoice">
                    <div class="form-group" id="fields" style="height: 266px; overflow-y: auto;">
                        <input type="text" name="q" class="form-control" id="question" placeholder="Skriv spørsmål her" required><br>
                        <label>Brøk 1</label>
                        <input type="number" class="form-control" id="numerator1" placeholder="Teller" autofocus required>
                        <input type="number" class="form-control" id="denominator1" placeholder="Nevner" required><br>
                        <label>Brøk 2</label>
                        <input type="number" class="form-control" id="numerator2" placeholder="Teller" required>
                        <input type="number" class="form-control" id="denominator2" placeholder="Nevner" required>
                    </div>
                    <div class="form-group">
                        <label>Skriv inn svar her</label>
                        <input type="number" value="" name="numerator" class="form-control" placeholder="Teller" required>
                        <input type="number" value="" name="denominator" class="form-control" placeholder="Nevner" required>
                    </div>
                   
                    <input type="button" id="lessFields" onclick="removeFields()" value="-">
                    <input type="button" id="moreFields" onclick="addFields()" value="+">
                    <br>
                    <br>
                    <button type="submit" class="btn btn-success" onclick="setText()">Legg til</button>
                     <a class="btn btn-primary" href="createtaskview" style="float: left">Tilbake</a>
                    <input type="hidden" id="hidden1" name="text">
                    <input type="hidden" id="hidden2" name="fractionsString">
                </form:form>
            </div>
        </div>
        
        <script>
            var counter = 3;
            function addFields() {
                document.getElementById('fields').innerHTML += '<br id="br' + counter + '"><label id="label' + counter + '">Brøk ' + counter + '</label> <input type="number" class="form-control" id="numerator' + counter + '" placeholder="Teller" required> <input type="number" class="form-control" id="denominator' + counter + '" placeholder="Nevner" required>';
                counter++;
            }

            function removeFields() {
            var something = (counter -1);
            if (something == 2) {
                return false;
            }
            counter--;
            var element1 = document.getElementById('br' + counter);
            element1.parentNode.removeChild(element1);
            var element2 = document.getElementById('label' + counter);
            element2.parentNode.removeChild(element2);
            var element3 = document.getElementById('numerator' + counter);
            element3.parentNode.removeChild(element3);
            var element4 = document.getElementById('denominator' + counter);
            element4.parentNode.removeChild(element4);
            }

            function setText() {
                var x = document.getElementById('question').value;
                var fractions = document.getElementById('numerator1').value + '/' + document.getElementById('denominator1').value;
                for (i = 2; i < counter; i++) {
                    fractions += '|' + document.getElementById('numerator' + i).value + '/' + document.getElementById('denominator' + i).value;
                }
                document.getElementById('hidden1').value = x;
                document.getElementById('hidden2').value = fractions;   
            }
        </script>
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    </body>
</html>