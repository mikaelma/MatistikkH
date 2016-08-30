<%-- 
    Document   : teacherclass
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
        
        <title>Legg til klasser</title>
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
                <center><h4>Legg til klasser for ${teacher.firstName} ${teacher.lastName}</h4></center>
                <center>Tildelte klasser: ${teacherClasses}</center>
            </div>
            <form:form action="addteacherclasses" method="POST" modelAttribute="classInfoFormBackingBean">
                <table id="table_id" class="table table-striped" cellspacing="0" width="100%">
                    <center>${teacher.username} - ${school} - Status: ${teacher.active ? "Aktiv" : "Inaktiv"}</center>
                    <thead>
                        <tr>
                            <th>Velg </th>
                            <th>Klasse </th>
                            <th>Antall studenter </th>
                        </tr>
                    </thead>
                    <tbody>     
                        <c:forEach var="classes" items="${classInfoFormBackingBean.allClasses}" varStatus="status">
                            <tr>
                                <td>
                                    <input type="checkbox" id="chosenClass${status.index}" name="checkboxes">
                                </td>
                                <td>
                                    <c:out value="${classes.className}"/>
                                    <input type="hidden" id="class${status.index}" value="${classes.classId}">
                                </td>
                                <td>
                                    <c:out value="${classes.students}"/>
                            </tr>    
                        </c:forEach>
                    </tbody>
                </table>
                
                
                <button type="submit" class="btn btn-success" name="submitClass" onclick="setClasses()">Legg til klasse</button>
                <input type="hidden" id="selected" name="selectedClasses">
                <input type="hidden" id="teacher" name="selectedTeacher" value="${teacher.username}">
                
                </form:form>
                <br>
                <div>
                <form:form action="activateuser">
                    <a href="getallusers" type="button" class="btn btn-primary">Tilbake</a>
                    <button type="submit" class="btn btn-warning" name="infoButton" onclick="setInfo()" style="float: right"><c:out value="${teacher.active ? 'Deaktiver' : 'Aktiver'}"/> ${teacher.username}</button>
                    <input type="hidden" id="teacherInfo" name="chosenEmail">
                    <input type="hidden" id="active" name="activeValue">
                </form:form>
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
            
            function setClasses(){
                var checkboxes = document.getElementsByName('checkboxes');
                var selectedClasses = "";
                for(var i=0; i<checkboxes.length; i++){
                    if(checkboxes[i].checked){
                        selectedClasses += document.getElementById("class"+i).value + "|";
                    }
                }
                document.getElementById("selected").value = selectedClasses;
            }
            
            function setInfo(){
                document.getElementById("teacherInfo").value = "${teacher.username}";
                if(${teacher.active}){
                    document.getElementById("active").value = "false";
                }else{
                    document.getElementById("active").value = "true";
                }
            }
        </script>
    </body>
</html>
