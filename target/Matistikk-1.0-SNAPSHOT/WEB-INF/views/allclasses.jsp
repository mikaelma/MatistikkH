<%-- 
    Document   : allclasses
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
        
        <title>Alle Klasser ved ${schoolName}</title>
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
                    <button type="button" class="btn btn-primary" data-toggle="modal" 
                            data-target="#classModal" style="float: right">
                        <span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Legg til klasse</button>
                    <h1>Klasseoversikt for ${schoolName}</h1>
                </div>
                    <div class="tab-content">
                        <div>
                            <form:form action="studentsclass" method="POST" modelAttribute="classInfoFormBackingBean"> 
                                <table id="table_id" class="table table-striped" cellspacing="0" width="100%">
                                    <thead>
                                        <tr>
                                            <th>Klasse</th>
                                            <th>Antall studenter</th>
                                            <th>Mer informasjon</th>
                                        </tr>
                                    </thead>
                                    <tbody>     
                                        <c:forEach var="classInfo" items="${classInfoFormBackingBean.allClasses}" varStatus="status">
                                            <tr>
                                            <td>
                                                <c:out value="${classInfo.className}"/>
                                                <form:hidden path="allClasses[${status.index}].className" />
                                            </td>
                                            <td>
                                                <c:out value="${classInfo.students}"/>
                                                <form:hidden path="allClasses[${status.index}].students" />
                                            </td>
                                            <td>
                                                <button type="submit" class="btn btn-link" name="studentclass" onclick="setSelected(${classInfo.classId}, '${classInfo.className}')"> Vis studenter </button>
                                            </td>
                                        </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <input type="hidden" id="hidden" name="selected">
                                <input type="hidden" name="schoolId" value="${schoolId}">
                                <input type="hidden" name="schoolName" value="${schoolName}">
                            </form:form>
                            <form:form action="allschools" method="POST" modelAttribute="schoolStatisticFormBackingBean">
                                <button type="submit" class="btn btn-primary">Tilbake</button>
                            </form:form>
                        </div>
                    </div>
                </div>
        
        <div class="modal fade" id="classModal" tabindex="-1" role="dialog" aria-labelledby="myClassLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myClassLabel"> Legg til klasse ved ${schoolName}</h4>
                    </div>
                    <div class="modal-body">
                        <form:form action="newclass" method="POST" modelAttribute="class">
                            <div class="form-group">
                                <label for="className">Klasse</label>
                                <input type="text" class="form-control" name="className" id="name" placeholder="Klasse" autofocus>
                            </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="Close">Avbryt</button>
                        <button type="submit" class="btn btn-primary">Legg til klasse</button>
                        <input type ="hidden" name="id" value="${schoolId}">
                        <input type ="hidden" name="name" value="${schoolName}">
                    </div>
                    </form:form>
                </div>
            </div>
        </div>
        
        
        <script>
            $(document).ready(function() {
                $('#table_id').DataTable();
            } );
            
            function setSelected(classId, className){
                document.getElementById('hidden').value = classId + "|" + className;
            }
            
        </script>
    </body>
</html>
