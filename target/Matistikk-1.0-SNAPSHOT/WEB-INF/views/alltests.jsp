<%-- 
    Document   : alltests
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
        
        <title>Alle tester</title>
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
                <center><h4>Alle tester</h4></center>
            </div>
            <form:form action="publishview" method="POST" modelAttribute="testStatisticFormBackingBean">
                <table id="table_id" class="table table-striped" cellspacing="0" width="100%">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="checkAll"></th>
                            <th>Test nr.</th>
                            <th>Laget av</th>
                            <th>Antall spørsmål</th>
                            <th>Antall publisert</th>
                            <th>Aktiv</th>
                            <th>Publiser</th>
                        </tr>
                    </thead>
                    <tbody>     
                        <c:forEach var="test" items="${testStatisticsFormBackingBean.allTestStatistics}" varStatus="status">
                            <tr>
                                <td>
                                    <input type="checkbox" id="${test.testId}" name="checkboxes">
                                </td>
                                <td>
                                Test <c:out value="${test.testId}"/>
                                <input type="hidden" id="testId${status.index}" value="${test.testId}">
                                </td>
                                <td>
                                    <c:out value="${test.username}"/>
                                </td>
                                <td>
                                    <c:out value="${test.taskCount}"/>
                                </td>
                                <td>
                                    <c:out value="${test.teacherCount}" />
                                </td>
                                <td>
                                    <c:out value="${test.active ? 'Aktiv' : 'Inaktiv'}"/>
                                </td>
                                <td>
                                    <button type="submit" class="btn btn-link" name="selectedTest" onclick="setTestId('${test.testId}')">Klikk her</button>
                                </td>
                            </tr>    
                        </c:forEach>
                    </tbody>
                </table> 
                <input type="hidden" id="selectedTest" name="testId">
            </form:form>
            <form action="download">
                <button type="submit" class="btn btn-success" name="download" onclick="exportTest()">Klikk her for å eksportere valgte tester</button>
                <input type="hidden" id="selected" name="selectedTests">
            </form>
            <div>
                <a href="home" type="button" class="btn btn-primary">Tilbake</a>
            </div>
            <br>
        </div>
        
        <script>
            $(document).ready(function() {
                $('#table_id').DataTable();
            } );
            $('#checkAll').click(function() {
                $(this).closest('table').find('td input:checkbox').prop('checked', this.checked);
            });
            function setTestId(testId) {
                document.getElementById('selectedTest').value = testId;
            }
            
            function exportTest(){
                var checkboxes = document.getElementsByName('checkboxes');
                var selectedTests = "";
                for(var i=0; i<checkboxes.length; i++){
                    if(checkboxes[i].checked){
                        selectedTests += document.getElementById("testId"+i).value + "|";
                    }
                }
                document.getElementById("selected").value = selectedTests;
            }
        </script>
    </body>
</html>
