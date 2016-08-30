<%-- 
    Document   : selectclasses
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
        
        <title>Publiser test ${testId}</title>
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
                <center><h4>Publiser test ${testId}</h4></center>
            </div>
            <form:form action="publishclasses" method="POST" modelAttribute="classInfoFormBackingBean">
                <table id="table_id" class="table table-striped" cellspacing="0" width="100%">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="checkAll"></th>
                            <th>Klasse</th>
                            <th>Antall studenter</th>
                        </tr>
                    </thead>
                    <tbody>     
                        <c:forEach var="classes" items="${classInfoFormBackingBean.allClasses}" varStatus="status">
                            <tr>
                                <td>
                                    <input type="checkbox" id="${status.index}" name="checkboxes">
                                </td>
                                <td>
                                    <c:out value="${classes.className}"/>
                                <input type="hidden" id="classes${status.index}" value="${classes.classId}">
                                </td>
                                <td>
                                    <c:out value="${classes.students}"/>
                                </td>
                            </tr>    
                        </c:forEach>
                    </tbody>
                </table><a href="home" class="btn btn-warning btn" role="button" style="width: 100px">Avbryt</a>
                <button type="submit" class="btn btn-success" style="width: 100px" name="submitBtn" onclick="setSelected()">Publiser</button>
                <input type="hidden" id="chosenClasses" name="selected">
                <input type="hidden" id="chosenTest" name="testId" value="${testId}">
                <span id="message"></span> 
            </form:form>
            
            
            
            <br>
        </div>
        
        <script>
            $(document).ready(function() {
                $('#table_id').DataTable();
            } );
            $('#checkAll').click(function() {
                $(this).closest('table').find('td input:checkbox').prop('checked', this.checked);
            });
            $('#form_check').on('submit', function (e) {
                var message = 'Du må velge minst en klasse for å publisere testen!';
                if ($("input[type=checkbox]:checked").length === 0) {
                    e.preventDefault();
                    $('#message').html(message);
                    return false;
                }
            });
            function setSelected(){
                var checkboxes = document.getElementsByName('checkboxes');
                var selectedClasses = "";
                for(var i=0; i<checkboxes.length; i++){
                    if(checkboxes[i].checked){
                        selectedClasses += document.getElementById("classes"+i).value + "|";
                    }
                }
                document.getElementById("chosenClasses").value = selectedClasses;
            }
        </script>
    </body>
</html>
