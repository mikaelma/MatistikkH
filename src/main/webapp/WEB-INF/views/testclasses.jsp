<%-- 
    Document   : testclasses
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
        
        <title>Publiser test</title>
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
                <center><h4>Publiser test</h4>
                </center>
            </div>
            <form:form action="testclasses" method="POST" modelAttribute="teacherStatisticsFormBackingBean">
                <table id="table_id" class="table table-striped" cellspacing="0" width="100%">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="checkAll"></th>
                            <th>Brukernavn</th>
                            <th>Navn</th>
                            <th>Klasser</th>
                        </tr>
                    </thead>
                    <tbody>     
                        <c:forEach var="teacher" items="${teacherStatisticsFormBackingBean.allTeachers}" varStatus="status">
                            <tr>
                                <td>
                                    <input type="checkbox" id="${status.index}" name="checkboxes">
                                    <input type="hidden" name="_selectedTeachers" value="on"/>
                                </td>
                                <td>
                                    <c:out value="${teacher.email}"/>
                                <input type="hidden" id="teacher${status.index}" value="${teacher.email}">
                                <form:hidden path="allTeachers[${status.index}].email"/>
                                </td>
                                <td>
                                    <c:out value="${teacher.firstName} ${teacher.lastName}"/>
                                    <form:hidden path="allTeachers[${status.index}].firstName"/>
                                </td>
                                <td>
                                    <c:out value="${teacher.schoolClasses}"/>
                                    <form:hidden path="allTeachers[${status.index}].school"/>
                                </td>
                            </tr>    
                        </c:forEach>
                    </tbody>
                </table>
                <a href="createtestview" class="btn btn-warning" role="button" style="width: 100px">Tilbake</a>
                <button type="submit" class="btn btn-success" style="width: 100px" name="submitBtn" onclick="setSelected()">Neste</button>
                <input type="hidden" id="chosenTeachers" name="selected">
                <input type="hidden" id="chosenTasks" name="tasks" value="${tasks}">
            </div>
            </form:form>
        
        <script>
            $(document).ready(function() {
                $('#table_id').DataTable();
            } );
            $('#checkAll').click(function() {
                $(this).closest('table').find('td input:checkbox').prop('checked', this.checked);
            });
            $('#form_check').on('submit', function (e) {
                var message = 'Du må velge minst en lærer for å publisere testen!';
                if ($("input[type=checkbox]:checked").length === 0) {
                    e.preventDefault();
                    $('#message').html(message);
                    return false;
                }
            });
            function setSelected(){
                var checkboxes = document.getElementsByName('checkboxes');
                var selectedTeachers = "";
                for(var i=0; i<checkboxes.length; i++){
                    if(checkboxes[i].checked){
                        selectedTeachers += document.getElementById("teacher"+i).value + "|";
                    }
                }
                document.getElementById("chosenTeachers").value = selectedTeachers;
            }
            
        </script>
    </body>
</html>
