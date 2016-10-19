<%-- 
    Document   : publishtests
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
        <title>Tilgjengelige Tester</title>
    </head>
    <body>
        <jsp:include page="/WEB-INF/views/styling.jsp"/>
        <jsp:include page="/WEB-INF/views/menu.jsp" />
        <div class="container">
            <div class="page-header">
                <h2>Tilgjengelige tester</h2>
            </div>
            <form:form action="selectclasses" method="POST" modelAttribute="testFormBackingBean">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <table class="table table-striped table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>Navn</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="test" items="${testFormBackingBean.allTests}" varStatus="status">
                                <tr>
                                    <td onclick="showInfo('${test.id}', '${test.size}', '${test.teacher}')" style="cursor: pointer">
                                        <c:out value="Test ${test.id}" />
                                    </td>
                                </tr>
                            </c:forEach>
                                <input type="hidden" id="hidden1" name="chosenTest">
                        </tbody>
                    </table>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title" id="test-info1">Informasjon </h3>
                        </div>
                        <div class="panel-body">
                            <p style="float: left" id="test-info2">Trykk på en av testene i listen til venstre for å få opp informasjon, og for å kunne publisere en test.</p>
                            <button value="Publiser test" id="test-button" style="float: right; display: none" type="submit" class="btn btn-primary btn-lg" name="hentTest"></button>
                        </div>
                    </div>
                </div>
            </form:form>
        </div>
    </div>
            <script>
                function showInfo(id, count, teacher) {
                    document.getElementById("test-button").innerHTML = "Publiser test";
                    document.getElementById("test-info1").innerHTML = "Test " + id;
                    document.getElementById("test-info2").innerHTML = "<b>Antall oppgaver: </b>" + count + "<br><b>Laget av: </b>" + teacher;
                    document.getElementById("test-button").style.display = "block";
                    document.getElementById('hidden1').value = id;
                }
            </script>
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    </body>
</html>
