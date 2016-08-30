<%-- 
    Document   : sort
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
        <title>Rekkefølge oppgave</title>
    </head>
    <body>
        <jsp:include page="/WEB-INF/views/menu.jsp"/>
        <jsp:include page="/WEB-INF/views/styling.jsp"/>
        <div class="container">
            <div class="jumbotron">
                <div class="page-header">
                    <p class="text-center">Oppgave av typen Rekkefølge</p>
                </div>
                <form:form action="addsorttask" method="POST" modelAttribute="sort">
                    <div class="form-group" id="fields" style="height: 380px; overflow-y: auto;">
                        <span id="question1">Plasser brøkene i</span>
                        <span>
                            <select id="question2" name="order">
                                <option value="stigende">stigende</option>
                                <option value="synkende">synkende</option>
                            </select>
                        </span>
                        <span id="question3">rekkefølge.</span>
                        <br>
                        <label>Brøk 1</label>
                        <input type="number" class="form-control" id="numerator1" placeholder="Teller" autofocus required>
                        <input type="number" class="form-control" id="denominator1" placeholder="Nevner" required><br>
                        <label>Brøk 2</label>
                        <input type="number" class="form-control" id="numerator2" placeholder="Teller" required>
                        <input type="number" class="form-control" id="denominator2" placeholder="Nevner" required>
                    </div>
                   
                    <input type="button" id="lessFields" onclick="removeFields()" value="-">
                    <input type="button" id="moreFields" onclick="addFields()" value="+">
                    <br>
                    <br>
                    <a class="btn btn-primary" href="createtaskview" style="float: left">Tilbake</a>
                    <button type="submit" class="btn btn-success" onclick="setText()">Legg til</button>
                    <input type="hidden" id="hidden1" name="text">
                    <input type="hidden" id="hidden2" name="fractionsString">
                    <input type="hidden" id="hidden3" name="sorting">
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
                var fields = (counter -1);
                if (fields == 2) {
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
                var x = document.getElementById('question1').innerHTML + ' ' + document.getElementById('question2').value + ' ' + document.getElementById('question3').innerHTML;
                var fractions = document.getElementById('numerator1').value + '/' + document.getElementById('denominator1').value;
                for (i = 2; i < counter; i++) {
                    fractions += '|' + document.getElementById('numerator' + i).value + '/' + document.getElementById('denominator' + i).value;
                }
                document.getElementById('hidden1').value = x;
                document.getElementById('hidden2').value = fractions;
                document.getElementById('hidden3').value = document.getElementById('question2').value;
            }
        </script>
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    </body>
</html>
