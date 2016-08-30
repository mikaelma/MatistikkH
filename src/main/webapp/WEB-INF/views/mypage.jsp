<%-- 
    Document   : mypage
    Author     : Team ENMAKA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="no">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width= device-witdh, initial-scale = 1">
        
        <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/formvalidation/0.6.1/css/formValidation.min.css">

        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script type="text/javascript" src="resources/bootstrap/js/bootstrap.min.js"></script>
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/formvalidation/0.6.1/js/formValidation.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/formvalidation/0.6.1/js/framework/bootstrap.min.js"></script>
        
        <script type="text/javascript" src="resources/formvalidation/dist/js/no_NO.js"></script> 
        <title>Min Side</title>
    </head>
    <body>
        <jsp:include page="/WEB-INF/views/styling.jsp"/>
        <jsp:include page="/WEB-INF/views/menu.jsp" />
        <div class="container">
            <!-- StudentView -->
            <c:if test= "${user.description == 'Student'}">
                <div class="page-header">
                    <h3>Min Side</h3>
                </div>
                <div class="row">
<!--                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        Antall tester tatt: <c:out value="${count}" />
                    </div>-->
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                        <h3>Endre passord</h3>
                        <form:form id="changePassword-form" action="changePW" method="POST" modelAttribute="password">
                            <div class="form-group">
                                <label for="#">Gammelt passord</label>
                                <input type="text" class="form-control" name="oldPassword" placeholder="Gammelt passord" required autofocus>
                            </div>
                            <div class="form-group">
                                <label for="#">Nytt passord</label>
                                <input type="text" class="form-control" name="newPassword1" placeholder="Nytt passord" required>
                            </div>
                            <div class="form-group">
                                <label for="#">Gjenta nytt passord</label>
                                <input type="text" class="form-control" name="newPassword2" placeholder="Nytt passord" required>
                            </div>
                            <div class="form-group">
                                <button type="submit" class="btn btn-success">Endre</button>
                            </div>
                        </form:form>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                        <h3>Endre klasse</h3>
                        <form:form action="joinclass" method="POST" modelAttribute="class">
                            <div class="form-group">
                                <label for="#">Klassekode</label>
                                <input type="number" class="form-control" name="classId" required>
                                <c:out value="${message}"/>
                            </div>
                            <div class="form-group">
                                <button type="submit" class="btn btn-success">Legg til</button>
                            </div>
                        </form:form>
                    </div>
                    <div class="col-lg-4w col-md-4 col-sm-4 col-xs-12">
                        <h3>Informasjon</h3>
                        <h5>Antall tester fullført: <b><c:out value="${testCompleteCount}" /></b></h5>
                        <h5>Antall tester ikke fullført: <b><c:out value="${testIncompleteCount}" /></b></h5>
                        <h5>Antall øvingstester fullført: <b><c:out value="${practiseTestCompleteCount}" /></b></h5>
                        <h5>Antall øvingstester ikke fullført: <b><c:out value="${practiseTestIncompleteCount}" /></b></h5>
                    </div>
                </div>
            </c:if>
            
            <!-- TeacherView -->
            <c:if test= "${user.description == 'Teacher' || user.description == 'Admin'}">
                <div class ="page-header">
                    <h3>Min side</h3>
                </div>        
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <p>Antall tester laget: <c:out value="${madeCount}" /> </p>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                        <h3>Endre passord</h3>
                        <form:form id="changePassword-form" action="changePW" method="POST" modelAttribute="password">
                            <div class="form-group">
                                <label>Gammelt passord</label>
                                <input type="text" class="form-control" name="oldPassword" placeholder="Gammelt passord">
                            </div>
                            <div class="form-group">
                                <label>Nytt passord</label>
                                <input type="text" class="form-control" name="newPassword1" placeholder="Nytt passord">
                            </div>
                            <div class="form-group">
                                <label>Gjenta nytt passord</label>
                                <input type="text" class="form-control" name="newPassword2" placeholder="Nytt passord">
                            </div>
                            <div class="form-group">
                                <button type="submit" class="btn btn-success">Endre</button>
                            </div>
                        </form:form>
                    </div>
                </div>
            </c:if>
        </div>
        
        <script>
            $(document).ready(function() {
                $('#changePassword-form').formValidation({
                    framework: 'bootstrap',
                    icon: {
                        valid: 'glyphicon glyphicon-ok',
                        invalid: 'glyphicon glyphicon-remove',
                        validating: 'glyphicon glyphicon-refresh'
                    },
                    locale: 'no_NO',
                    fields: {
                        oldPassword: {
                            validators: {
                                notEmpty: {
                                }
                            }
                        },
                        newPassword1: {
                            validators: {
                                notEmpty: {
                                },
                                stringLength: {
                                    min: 6,
                                    max: 30
                                },
                                regexp: {
                                    regexp: /^[a-zA-Z0-9_]+$/
                                }
                            }
                        },
                        newPassword2: {
                            validators: {
                                notEmpty: {
                                },
                                stringLength: {
                                    min: 6,
                                    max: 30
                                },
                                regexp: {
                                    regexp: /^[a-zA-Z0-9_]+$/
                                }
                            }
                        }
                    }
                });
            });
        </script>
    </body>
</html>