<%-- 
    Document   : tests
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
        <title>Tester</title>
    </head>
    <body>
        <jsp:include page="/WEB-INF/views/styling.jsp"/>
        <jsp:include page="/WEB-INF/views/menu.jsp" />
        <div class="container">
            <div class="page-header">
                <h2>Tilgjengelige tester</h2>
            </div>
            <div class="tabbable">
                <ul class="nav nav-pills nav-justified">
                    <li class="active"><a href="#A" data-toggle="tab">Tester</a></li>
                    <li><a href="#B" data-toggle="tab">Øvingstester</a></li>
                </ul>
                <br><br>
                <div class="tab-content">
                    <div id="A" class="tab-pane active">
                        <form:form action="gettest" method="POST" modelAttribute="testFormBackingBean">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>Navn</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="test" items="${testFormBackingBean.allTestableTests}" varStatus="status">
                                            <tr>
                                                <td onclick="showInfo('${test.id}', '${test.size}', '${test.teacher}', '${test.progress}')" style="cursor: pointer">
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
                                        <p style="float: left" id="test-info2">Trykk på en av testene i listen til venstre for å få opp informasjon, og for å kunne ta en test.</p>
                                        <button value="Ta test" id="test-button" style="float: right; display: none" type="submit" 
                                                class="btn btn-primary btn-lg" name="hentTest"></button>
            <!--                            <a href="starttest" class="btn btn-primary btn-lg" id="test-button" style="float: right; display: none" type="button">Ta test</a>-->
                                    </div>
                                </div>
                            </div>
                        </form:form>
                    </div>
                    <div id="B" class="tab-pane">
                        <form:form action="gettest" method="POST" modelAttribute="testFormBackingBean">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>Navn</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="test" items="${testFormBackingBean.allPractiseTests}" varStatus="status">
                                            <tr>
                                                <td onclick="showInfo2('${test.id}', '${test.size}', '${test.teacher}', '${test.progress}')" style="cursor: pointer">
                                                    <c:out value="Test ${test.id}" />
                                                </td>
                                            </tr>
                                        </c:forEach>
                                            <input type="hidden" id="hidden2" name="chosenTest">
                                    </tbody>
                                </table>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h3 class="panel-title" id="test-info3">Informasjon </h3>
                                    </div>
                                    <div class="panel-body">
                                        <p style="float: left" id="test-info4">Trykk på en av testene i listen til venstre for å få opp informasjon, og for å kunne ta en test.</p>
                                        <button value="Ta test" id="test-button2" style="float: right; display: none" type="submit" 
                                                class="btn btn-primary btn-lg" name="hentTest"></button>
            <!--                            <a href="starttest" class="btn btn-primary btn-lg" id="test-button" style="float: right; display: none" type="button">Ta test</a>-->
                                    </div>
                                </div>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
        
        <script>
            function showInfo(id, count, teacher, progress) {
                var s = "";
                if(progress > 0){
                    s = "<br><b>Utførte oppgaver: </b>" + progress;
                    document.getElementById("test-button").innerHTML = "Fortsett test";
                }else{
                    document.getElementById("test-button").innerHTML = "Ta test";
                }
                document.getElementById("test-info1").innerHTML = "Test " + id;
                document.getElementById("test-info2").innerHTML = "<b>Antall oppgaver: </b>" + count + "<br><b>Laget av: </b>" + teacher + s;
                document.getElementById("test-button").style.display = "block";
                document.getElementById('hidden1').value = id;
            }
            function showInfo2(id, count, teacher, progress) {
                var s = "";
                if(progress > 0){
                    s = "<br><b>Utførte oppgaver: </b>" + progress;
                    document.getElementById("test-button2").innerHTML = "Fortsett test";
                }else{
                    document.getElementById("test-button2").innerHTML = "Ta test";
                }
                document.getElementById("test-info3").innerHTML = "Test " + id;
                document.getElementById("test-info4").innerHTML = "<b>Antall oppgaver: </b>" + count + "<br><b>Laget av: </b>" + teacher + s;
                document.getElementById("test-button2").style.display = "block";
                document.getElementById('hidden2').value = id;
            }
        </script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
        
    </body>
</html>
