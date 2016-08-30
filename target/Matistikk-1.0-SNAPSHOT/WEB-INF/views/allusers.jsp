<%-- 
    Document   : allusers
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
        
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/formvalidation/0.6.1/css/formValidation.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/formvalidation/0.6.1/js/formValidation.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/formvalidation/0.6.1/js/framework/bootstrap.min.js"></script>
        
        <script type="text/javascript" src="resources/formvalidation/dist/js/no_NO.js"></script>
        
        <title>Alle Studenter</title>
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
            <c:if test="${sessionScope.user.description == 'Teacher'}">
                <div class="page-header">
                    <h1>Studenter</h1>
                </div>
                <form:form action="getallusers" method="GET" modelAttribute="userFormBackingBean"> 
                    <table id="table_id" class="table table-striped" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th>Brukernavn</th>
                                <th>Utførte tester</th>
                                <th>Alder</th>
                                <th>Kjønn</th>
                                <th>Skole</th>
                                <th>Klasse</th>
                            </tr>
                        </thead>
                        <tbody>     
                            <c:forEach var="student" items="${userFormBackingBean.allStudents}" varStatus="status">
                            <tr data-toggle="collapse" data-target="#${status.index}">
                                <td>
                                    <c:out value="${student.email}"/>
                                    <form:hidden path="allStudents[${status.index}].email" />
                                </td>
                                <td>
                                    <c:out value="${student.testCount}"/>
                                    <form:hidden path="allStudents[${status.index}].testCount" />
                                </td>
                                
                                <td>
                                    <c:out value="${student.age}"/>
                                    <form:hidden path="allStudents[${status.index}].age" /> 
                                </td>
                                <td>
                                    <c:out value="${student.sex ? 'Mann' : 'Dame'}" />
                                </td>
                                <td>
                                    <c:out value="${student.school}"/>
                                    <form:hidden path="allStudents[${status.index}].school" />
                                </td>
                                <td>
                                    <c:out value="${student.className}"/>
                                    <form:hidden path="allStudents[${status.index}].className" />
                                </td>
                            </tr>
                            <tr class="hiddenRow">
                                <td>
                                    <div id="${status.index}" class="collapse">
                                        <c:out value="${student.username}"/>
                                    <form:hidden path="allStudents[${status.index}].username" />
                                    </div>
                                </td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </form:form>
            </c:if>
            
            <c:if test="${sessionScope.user.description == 'Admin'}">
                <div class="page-header">
                    <button type="button" class="btn btn-primary" data-toggle="modal" 
                            data-target="#teacherModal" style="float: right">
                        <span class="glyphicon glyphicon-plus" aria-hidden="true"></span> Legg til lærer</button>
                    <h1>Brukeroversikt</h1>
                </div>
                
                <div class="tabbable">
                    <ul class="nav nav-pills nav-justified">
                        <li class="active"><a href="#A" data-toggle="tab">Brukere</a></li>
                        <li><a href="#B" data-toggle="tab">Lærere</a></li>
                    </ul>
                    <br><br>
                    <div class="tab-content">
                        <div id="A" class="tab-pane active">
                            <form:form action="getallusers" method="GET" modelAttribute="userFormBackingBean"> 
                                <table id="table_id" class="table table-striped" cellspacing="0" width="100%">
                                    <thead>
                                        <tr>
                                            <th>Brukernavn</th>
                                            <th>Utførte tester</th>
                                            <th>Alder</th>
                                            <th>Kjønn</th>
                                            <th>Skole</th>
                                            <th>Klasse</th>
                                            <th>Administrer student</th>
                                        </tr>
                                    </thead>
                                    <tbody>     
                                        <c:forEach var="student" items="${userFormBackingBean.allStudents}" varStatus="status">
                                        <tr data-toggle="collapse" data-target="#${status.index}">
                                            <td>
                                                <c:out value="${student.email}"/>
                                                <form:hidden path="allStudents[${status.index}].email" />
                                            </td>
                                            <td>
                                                <c:out value="${student.testCount}"/>
                                                <form:hidden path="allStudents[${status.index}].testCount" />
                                            </td>

                                            <td>
                                                <c:out value="${student.age}"/>
                                                <form:hidden path="allStudents[${status.index}].age" /> 
                                            </td>
                                            <td>
                                                <c:out value="${student.sex ? 'Mann' : 'Dame'}" />
                                            </td>
                                            <td>
                                                <c:out value="${student.school}"/>
                                                <form:hidden path="allStudents[${status.index}].school" />
                                            </td>
                                            <td>
                                                <c:out value="${student.className}"/>
                                                <form:hidden path="allStudents[${status.index}].className" />
                                            </td>
                                            <td>
                                                <button type="button" class="btn btn-link" data-toggle="modal" 
                                                    data-target="#studentModal" onclick="setStudent('${student.email}', ${student.active})">Klikk her</button>
                                            </td>
                                        </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </form:form>
                        </div>
                        <div id="B" class="tab-pane">
                            <form:form action="teacherclass" method="POST" modelAttribute="userFormBackingBean"> 
                                <table id="table_id2" class="table table-striped" cellspacing="0" width="100%">
                                    <thead>
                                        <tr>
                                            <th>Navn</th>
                                            <th>Antall tester laget</th>
                                            <th>Skole</th>
                                            <th>Administrer lærer</th>
                                        </tr>
                                    </thead>
                                    <tbody>     
                                        <c:forEach var="teacher" items="${userFormBackingBean.allTeachers}" varStatus="status">
                                            <tr>
                                            <td>
                                                <c:out value="${teacher.firstName} ${teacher.lastName}"/>
                                                <form:hidden path="allTeachers[${status.index}].firstName" />
                                            </td>
                                            <td>
                                                <c:out value="${teacher.testCount}"/>
                                                <form:hidden path="allTeachers[${status.index}].testCount" />
                                            </td>
                                            <td>
                                                <c:out value="${teacher.schoolName}"/>
                                                <form:hidden path="allTeachers[${status.index}].schoolName" />
                                            </td>
                                            <td>
                                                <button type="submit" class="btn btn-link" name="teacherclass" onclick="setSelected('${teacher.username}', '${teacher.schoolName}')"> Klikk her </button>
                                            </td>
                                        </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <input type="hidden" id="hidden" name="selected">
                                <input type="hidden" id="hidden2" name="school">
                            </form:form>
                        </div>
                    </div>
                </div>
            </c:if>
            <div>
                <a href="home" type="button" class="btn btn-primary">Tilbake</a>
            </div>
        </div>
        
        <div class="modal fade" id="teacherModal" tabindex="-1" role="dialog" aria-labelledby="myTeacherLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myTeacherLabel"> Legg til lærer</h4>
                    </div>
                    <div class="modal-body">
                        <form:form id="newteacher-form" action="newteacher" method="POST" modelAttribute="teacher">
                            <div class="form-group">
                                <label>Fornavn</label>
                                <input type="text" class="form-control" name="firstName" placeholder="Fornavn" required autofocus>
                            </div>
                            <div class="form-group">
                                <label>Etternavn</label>
                                <input type="text" class="form-control" name="lastName" placeholder="Etternavn" required>
                            </div>
                            <div class="form-group">
                                <label>Brukernavn</label>
                                <input type="text" class="form-control" name="username" placeholder="Email" required>
                            </div>
                            <div class="form-group">
                                <label>Skole</label>
                                <br>
                                <select name="schoolId">
                                    <option value="">Velg skole</option>
                                    <c:forEach var="school" items="${schools}">
                                        <option value="${school.schoolId}"><c:out value="${school.schoolName}"/></option>
                                    </c:forEach>
                                </select>
                            </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="Close">Avbryt</button>
                        <button type="submit" class="btn btn-primary">Legg til lærer</button>
                    </div>
                    </form:form>
                </div>
            </div>
        </div>
        <div class="modal fade" id="studentModal" tabindex="-1" role="dialog" aria-labelledby="myStudentLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myStudentLabel">Administrer student</h4>
                    </div>
                    <div class="modal-body">
                        <form:form action="activateuser" method="POST">
                            <div class="form-group">
                                <p id="pText"></p> 
                                <button type="submit" class="btn btn-warning" id="setActive"></button>
                                <input type="hidden" id="chosenStudent" name="chosenEmail">
                                <input type="hidden" id="chosenActive" name="activeValue">
                            </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="Close">Avbryt</button>
                    </div>
                    </form:form>
                </div>
            </div>
        </div>
        
        <script>
            $(document).ready(function() {
                $('#table_id').DataTable();
                $('#table_id2').DataTable();
            
            });
            
            function setSelected(selected, school){
                document.getElementById('hidden').value = selected;
                document.getElementById('hidden2').value = school;
            }
            
            function setStudent(email, active){
                if(active){
                    document.getElementById('setActive').textContent = "Deaktiver student";
                    document.getElementById('chosenActive').value = 'false';
                    document.getElementById('pText').textContent = "Her kan du deaktivere tilgangen for " + email + ".";
                }else{
                    document.getElementById('setActive').textContent = "Aktiver student";
                    document.getElementById('chosenActive').value = 'true';
                    document.getElementById('pText').textContent = "Her kan du aktivere tilgangen for " + email + ".";
                }
                document.getElementById('chosenStudent').value = email;
            }
        </script>
    </body>
</html>
