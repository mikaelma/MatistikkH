<%-- 
    Document   : allschools
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
        
        <title>Alle Skoler</title>
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
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#schoolModal" style="float: right">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Legg til skole</button>
                <h1>Skoleoversikt</h1>
            </div>
            <div class="tab-content">
                <div>
                    <form:form action="schoolclass" method="POST" modelAttribute="schoolInfoFormBackingBean"> 
                        <table id="table_id" class="table table-striped" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>Navn</th>
                                    <th>Antall klasser</th>
                                    <th>Mer informasjon</th>
                                </tr>
                            </thead>
                            <tbody>     
                                <c:forEach var="school" items="${schoolInfoFormBackingBean.allSchools}" varStatus="status">
                                    <tr>
                                    <td>
                                        <c:out value="${school.schoolName}"/>
                                        <form:hidden path="allSchools[${status.index}].schoolName" />
                                    </td>
                                    <td>
                                        <c:out value="${school.classCount}"/>
                                        <form:hidden path="allSchools[${status.index}].classCount" />
                                    </td>
                                    <td>
                                        <button type="submit" class="btn btn-link" name="schoolclass" onclick="setSelected(${school.schoolId}, '${school.schoolName}')"> Vis klasser </button>
                                    </td>
                                </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <input type="hidden" id="hidden" name="selected">
                    </form:form>
                </div>
            </div>
            <div>
                <a href="home" type="button" class="btn btn-primary">Tilbake</a>
            </div>
        </div>
        
        <div class="modal fade" id="schoolModal" tabindex="-1" role="dialog" aria-labelledby="mySchoolLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="mySchoolLabel"> Legg til skole</h4>
                    </div>
                    <div class="modal-body">
                        <form:form action="newschool" method="POST" modelAttribute="school">
                            <div class="form-group">
                                <label for="schoolName">Navn</label>
                                <input type="text" class="form-control" name="schoolName" id="name" placeholder="Navn" autofocus>
                            </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="Close">Avbryt</button>
                        <button type="submit" class="btn btn-primary">Legg til skole</button>
                    </div>
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
