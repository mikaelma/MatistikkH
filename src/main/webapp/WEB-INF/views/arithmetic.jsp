<%-- 
    Document   : arithmetic
    Author     : Team ENMAKA
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>

<!DOCTYPE html>
<html lang="no">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width= device-witdh, initial-scale = 1">
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"> 
        <title>Aritmetikk oppgave</title>
        <style>
            .form-control {
                width: 20%;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/WEB-INF/views/menu.jsp"/>
        <jsp:include page="/WEB-INF/views/styling.jsp"/>
        <div class="container">
            <div class="jumbotron">
                <div class="page-header">
                    <p class="text-center">Oppgave av typen Aritmetikk</p>
                </div>
                <form:form action="addarithmetictask" method="POST" modelAttribute="arithmetic">
                    <div class="form-group" id="fields">
                        <input type="text" class="form-control" id="question" value="Hva er summen av" required><br>
                        <input type="number" class="form-control" id="numerator1" placeholder="Teller" autofocus required>
                        <input type="number" class="form-control" id="denominator1" placeholder="Nevner" required>

                        <select required id="options1">
                            <option value="">Velg operand</option>
                            <option value="+">+</option>
                            <option value="-">-</option>
                            <option value="*">*</option>
                            <option value="/">/</option>
                        </select>
                        <input type="number" class="form-control" id="numerator2" placeholder="Teller" required>
                        <input type="number" class="form-control" id="denominator2" placeholder="Nevner" required>
                    </div>
                    <div class="form-group">
                        <label>Skriv inn svar her</label>
                        <input type="number" name="numerator" class="form-control" placeholder="Teller" required>
                        <input type="number" name="denominator" class="form-control" placeholder="Nevner" required>
                    </div>
                    <input type="button" id="moreFields" onclick="addFields()" value="+">
                     <input type="button" id="lessFields" onclick="removeFields()" value="-">
                     <br>
                     <br>
                     <a class="btn btn-primary" href="createtaskview">Tilbake</a>
                    <button type="submit" class="btn btn-success" onclick="setText()">Legg til</button>
                    <input type="hidden" id="hidden" name="text">
                </form:form>
            </div>
        </div>
            <script>
                var counter = 3;
                function addFields() {
                    var i = counter-1;
                    document.getElementById('fields').innerHTML += '<select required id="options' + i +'"><option value="">Velg operand</option> <option value="+">+</option> <option value="-">-</option> <option value="*">*</option> <option value="/">/</option> </select> <input type="number" class="form-control" id="numerator' + counter + '" placeholder="Teller" required> <input type="number" class="form-control" id="denominator' + counter + '" placeholder="Nevner" required>';
                    counter++;
                }
                
                  function removeFields() {
                var something = (counter -1);
                if (something == 2) {
                    alert("Hei");
                    return false;
                }
                counter--;
                var element1 = document.getElementById('options' + (counter-1));
                element1.parentNode.removeChild(element1);
                var element1 = document.getElementById('numerator' + counter);
                element1.parentNode.removeChild(element1);
                var element1 = document.getElementById('denominator' + counter);
                element1.parentNode.removeChild(element1);
                
            }

                
                function setText() {
                    var x = document.getElementById('question').value + ' ' + document.getElementById('numerator1').value + '/' + document.getElementById('denominator1').value + ' ' + document.getElementById('options1').value + ' ' + document.getElementById('numerator2').value + '/' + document.getElementById('denominator2').value;
                    for (i = 3; i < counter; i++) {
                        var j = i-1;
                        x += ' ' + document.getElementById('options' + j).value + ' ' + document.getElementById('numerator' + i).value + '/' + document.getElementById('denominator' + i).value;
                    } 
                    
                    document.getElementById('hidden').value = x + '?';
                }
            </script>
            
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    </body>
</html>
