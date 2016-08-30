<%-- 
    Document   : newtest
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
        <title>Opprett ny test</title>
    </head>
    <body>
        <jsp:include page="/WEB-INF/views/menu.jsp"/>
        <jsp:include page="/WEB-INF/views/styling.jsp"/>
        <div class="container">
            <div class="page-header">
                <h3>Opprett ny test</h3>
            </div>
            
            <form:form action="createnewtest" method="POST">
                <div class="col-lg-10 col-md-10 col-sm-10 col-xs-10">
                    <h4>Valgte oppgaver</h4><br>
                    <table class="table" style="width: 100%" id="tableId">
                        <thead>
                            <tr>
                                <th>Oppgave ID</th>
                                <th>Oppgave type</th>
                                <th>Oppgavetekst</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${taskFormBackingBean.selectedTasks}" var="task" varStatus="status">
                                <tr>
                                    <td id="taskId${status.index}"><c:out value="${task.id}" /></td>
                                    <td><c:out value="${task.taskType}" /></td>
                                    <td><c:out value="${task.text}" /></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="col-lg-2 col-md-2 col-sm-2 col-xs-2">
                    <br><br>
                    Status: <br><select name="active" required="">
                        <option value="true">Aktiv</option>
                        <option value="false">Inaktiv</option>
                    </select>
                </div>
                
            <table class="table" id="teacherTable">
                <c:if test="${sessionScope.user.description == 'Admin'}">
                <thead>
                    <tr>
                        <th>Valgte lærere</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${teachers}" var="teacher" varStatus="status">
                        <tr>
                            <td id="teacher${status.index}"><c:out value="${teacher}"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
                </c:if>
            </table>
                
                
                <div>
                    <button type="submit" class="btn btn-success" onclick="setText()">Opprett ny test</button>
                <input type="hidden" id="tasks" name="testtasks" value="${tasks}">
                <input type="hidden" id="chosenTeachers" name="teachers">
                </form:form></div>
                
            <!--Tilbake-knapp: Se også MainController @RequestMapping(value = "back")-->
            <form:form action="back" method="POST">
                <button type="submit" class="btn btn-warning">Tilbake</button>
                <input type="hidden" name="back" value="${tasks}">
            </form:form>
        </div>
       
        
        <script>
            var rows = document.getElementById('teacherTable').getElementsByTagName("tbody")[0].getElementsByTagName("tr").length;
            function setText() {
                var y = "";
                for(i = 0; i<rows; i++){
                    y += document.getElementById("teacher"+i).innerHTML + "|";
                }
                document.getElementById('chosenTeachers').value = y;
            }
        </script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    </body>
</html>
