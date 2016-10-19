<%-- 
    Document   : allstudentclass
    Author     : Team ENMAKA
--%>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
        
        <title>Alle Studenter ${className}</title>
        <style>
            .hiddenRow {
            padding: 0 !important;
            }
            .modal-backdrop {
                z-index: 0;
            }
            .cont {
                height: auto !important;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/WEB-INF/views/menu.jsp"/>
        <jsp:include page="/WEB-INF/views/styling.jsp"/>
        <div class="container" id="cont">
                <div class="page-header">
                    <h1>Studentoversikt for ${className} ved ${schoolName}</h1>
                </div>
                    <div class="tab-content">
                        <div>
                            <form:form action="schoolclass" method="POST" modelAttribute="userFormBackingBean"> 
                                <table id="table_id" class="table table-striped" cellspacing="0" width="100%">
                                    <thead>
                                        <tr>
                                            <th>Brukernavn</th>
                                            <th>Alder</th>
                                            <th>Kjønn</th>
                                            <th>Antall tester tatt</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>     
                                        <c:forEach var="student" items="${userFormBackingBean.allStudents}" varStatus="status">
                                            <tr>
                                            <td>
                                                <c:out value="${student.email}"/>
                                                <form:hidden path="allStudents[${status.index}].email" />
                                            </td>
                                            <td>
                                                <c:out value="${student.age}"/>
                                                <form:hidden path="allStudents[${status.index}].age" />
                                            </td>
                                            <td>
                                                <c:out value="${student.sex ? 'Mann' : 'Kvinne'}"/>
                                            </td>
                                            <td>
                                                <c:out value="${student.testCount}"/>
                                                <form:hidden path="allStudents[${status.index}].testCount" />
                                            </td>
                                            <td>
                                                <c:out value="${student.active ? 'Aktiv' : 'Inaktiv'}"/>
                                            </td>
                                        </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <button type="submit" class="btn btn-primary" onclick="setSelected(${schoolId}, '${schoolName}')">Tilbake</button>
                                <input type="hidden" id="hidden" name="selected">
                            </form:form>
                        </div>
                    </div>
                </div>
        <script>
            $(document).ready(function() {
                $('#table_id').DataTable();
            } );
            
            function setSelected(schoolId, schoolName){
                document.getElementById('hidden').value = schoolId + "|" + schoolName;
            }
            
        </script>
    </body>
</html>
