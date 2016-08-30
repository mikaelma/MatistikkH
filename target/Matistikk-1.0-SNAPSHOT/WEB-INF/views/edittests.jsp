<%-- 
    Document   : edittests
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
        <title>Rediger øvingstester</title>
    </head>
    <body>
        <jsp:include page="/WEB-INF/views/menu.jsp"/>
        <jsp:include page="/WEB-INF/views/styling.jsp"/>
        <div class="container">
            <!--TeacherView-->
            <c:if test= "${sessionScope.user.description == 'Teacher'}">
                <div class="page-header">
                    <h4>Rediger tester</h4>
                </div>
                <form:form action="edittest" method="POST" modelAttribute="testFormBackingBean">
                    <table id="table_id1" class="table table-striped" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th>Test ID</th>
                                <th>Antall oppgaver</th>
                                <th>Aktiv/inaktiv</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="test" items="${testFormBackingBean.allTests}" varStatus="status">
                                <tr>
                                    <td>
                                        <c:out value="${test.id}"/>
                                        <form:hidden path="allTests[${status.index}].id" />
                                    </td>
                                    <td>
                                        <c:out value="${test.size}"/>
                                        
                                    </td>
                                    <td>
                                        <form:select path="allTests[${status.index}].active">
                                            <c:choose>
                                                <c:when test="${test.active == true}">
                                                    <option value="true" selected="selected">Aktiv</option>
                                                    <option value="false">Inaktiv</option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="true">Aktiv</option>
                                                    <option value="false" selected="selected">Inaktiv</option>
                                                </c:otherwise>
                                            </c:choose>
                                        </form:select>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <button type="submit" class="btn btn-success">Oppdater</button>
                </form:form>
            </c:if>
                    
            <!--AdminView-->
            
            <c:if test= "${sessionScope.user.description == 'Admin'}">
                <div class="page-header">
                    <h4>Administrer tester</h4>
                </div>
                <form:form action="edittestadmin" method="POST">
                    <table id="table_id2" class="table table-striped" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th>Test ID</th>
                                <th>Laget av</th>
                                <th>Antall oppgaver</th>
                                <th>Aktiv/inaktiv</th>
                                <th>Flere valg</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="test" items="${testFormBackingBean.allTests}" varStatus="status">
                                <tr>
                                    <td><c:out value="${test.id}"/></td>
                                    <td><c:out value="${test.teacher}"/></td>
                                    <td><c:out value="${test.size}"/></td>
                                    <td><c:out value="${test.active ? 'Aktiv' : 'Inaktiv'}"/></td>
                                    <td><button type="submit" class="btn btn-link" onclick="setTestId('${test.id}')" style="border: none">Klikk her</button></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <input type="hidden" id="hidden" name="testId">
                </form:form>
            </c:if>
        </div>
        
        <script>
            $(document).ready(function() {
                $('#table_id1').DataTable();
                $('#table_id2').DataTable();
            });
            function setTestId(testId) {
                document.getElementById('hidden').value = testId;
            }
        </script>
    </body>
</html>
