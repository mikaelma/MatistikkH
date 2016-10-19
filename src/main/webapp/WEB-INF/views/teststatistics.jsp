<%-- 
    Document   : teststatistics
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
        <meta name="viewport" content="width= device-width, initial-scale = 1">
        
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        
        <link rel="stylesheet" type="text/css" href="resources/bootstrap/css/bootstrap.min.css">
        <script type="text/javascript" language="javascript" src="resources/bootstrap/js/bootstrap.min.js"></script>
        
        <link rel="stylesheet" type="text/css" href="resources/DataTables/DataTables-1.10.11/css/dataTables.foundation.min.css">
	<script type="text/javascript" language="javascript" src="resources/DataTables/DataTables-1.10.11/js/jquery.dataTables.min.js"></script>        
	<script type="text/javascript" language="javascript" src="resources/DataTables/DataTables-1.10.11/js/dataTables.bootstrap.min.js"></script>
        
        <title>Statistikk</title>
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
                <center><h4>Statistikk - Test ${testId}</h4></center>
            </div>
            <form:form action="taskstatistics" method="POST" >
                <table id="table_id" class="table table-striped" cellspacing="0" width="100%">
                    <thead>
                        <tr>
                            <th>Oppgave nr.</th>
                            <th>Antall deltagere</th>
                            <th>Antall riktig</th>
                            <th>Antall feil</th>
                            <th>Mer informasjon</th>
                        </tr>
                    </thead>
                    <tbody>     
                        <c:forEach var="task" items="${taskStatisticsFormBackingBean.allTaskStatistics}" varStatus="status">
                            <tr>
                                <td>
                                Oppgave <c:out value="${task.taskId}"/>
                                </td>
                                <td>
                                    <c:out value="${task.students}"/>
                                </td>
                                <td>
                                    <c:out value="${task.correct}"/>
                                </td>
                                <td>
                                    <c:out value="${task.wrong}" />
                                </td>
                                <td>
                                    <button type="submit" class="btn btn-link" onclick="setTaskId('${task.taskId}')">Klikk her</button>
                                </td>
                            </tr>    
                        </c:forEach>
                    </tbody>
                </table>
                <input type="hidden" id="hidden1" name="testId" value="${testId}">
                <input type="hidden" id="hidden2" name="taskId">
            </form:form>
            <div>
                <a href="statisticview" type="button" class="btn btn-primary">Tilbake</a>
            </div>
            <br>
        </div>
        
        <script>
            $(document).ready(function() {
                $('#table_id').DataTable();
            } );            
        </script>
        <script>
            function setTaskId(taskId) {
                document.getElementById('hidden2').value = taskId;
            }
        </script>
    </body>
</html>
