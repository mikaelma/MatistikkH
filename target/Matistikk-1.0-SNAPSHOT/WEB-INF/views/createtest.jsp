<%-- 
    Document   : createtest
    Author     : Team ENMAKA
--%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="no">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width= device-width, initial-scale = 1">
        
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        
        <link rel="stylesheet" type="text/css" href="resources/bootstrap/css/bootstrap.min.css">
        <script type="text/javascript" language="javascript" src="resources/bootstrap/js/bootstrap.min.js"></script>
        
        <link rel="stylesheet" type="text/css" href="resources/DataTables/DataTables-1.10.11/css/dataTables.foundation.min.css">
	<script type="text/javascript" language="javascript" src="resources/DataTables/DataTables-1.10.11/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" language="javascript" src="resources/DataTables/DataTables-1.10.11/js/dataTables.bootstrap.min.js"></script>
        
        <title>Lag test</title>
        <style>
            .container {
                height: auto !important;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/WEB-INF/views/menu.jsp"/>
        <jsp:include page="/WEB-INF/views/styling.jsp"/>
        <div class="container">
            <div class="page-header">
                <h4>Eksisterende oppgaver</h4>
            </div>
            <form:form action="newtest" method="POST" modelAttribute="taskFormBackingBean" id="form_check">
                <table id="table_id" class="table table-striped" cellspacing="0" width="100%">
                    <thead>
                        <tr>
                            <th>Velg</th>
                            <th>Oppgavetype</th>
                            <th>Oppgavetekst</th>
                            <th>Laget av </th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="task" items="${taskFormBackingBean.allTasks}" varStatus="status">
                            <tr>
                                <td>
                                    <input id="selectedTasks${status.index}" name="selectedTasks" type="checkbox" value="${task.id}"/>
                                    <input type="hidden" name="_selectedTasks" value="on"/>
                                    <form:hidden path="allTasks[${status.index}].id" />
                                </td>
                                <td>
                                    <c:out value="${task.taskType}" />
                                    <form:hidden path="allTasks[${status.index}].taskType" />
                                </td>
                                <td>
                                    <c:out value="${task.text}" />
                                    <form:hidden path="allTasks[${status.index}].text" />
                                </td>
                                <td>
                                    <c:out value="${task.username}" />
                                    <form:hidden path="allTasks[${status.index}].username" />
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <a href="home" class="btn btn-warning btn-lg" role="button" style="width: 100px">Avbryt</a>
                <button type="submit" class="btn btn-primary btn-lg" style="width: 100px" name="selected" value="Selected Tasks">Velg</button>
                <span id="message"></span>
            </form:form>
            <center>
                <a href="createtaskview" class="btn btn-primary btn-lg" role="button">Lag egne oppgaver</a>
            </center>
        </div>
        
        <script>
            $(document).ready(function() {
                $('#table_id').DataTable();
            } );
            $('#form_check').on('submit', function (e) {
                var message = 'Du må velge minst en oppgave for å lage en test!';
                if ($("input[type=checkbox]:checked").length === 0) {
                    e.preventDefault();
                    $('#message').html(message);
                    return false;
                }
            });
          
            
        </script>            
    </body>
</html>
