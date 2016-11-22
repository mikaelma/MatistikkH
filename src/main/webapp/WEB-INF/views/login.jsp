<%-- 
    Document   : login
    Author     : Team ENMAKA
--%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>

<!DOCTYPE html>
<html lang="no">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width= device-width, initial-scale = 1">
        
        <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/jquery.formvalidation/0.6.1/css/formValidation.min.css">

        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script type="text/javascript" src="resources/bootstrap/js/bootstrap.min.js"></script>
        
        <script src="https://cdn.jsdelivr.net/jquery.formvalidation/0.6.1/js/formValidation.min.js"></script>
        <script src="https://cdn.jsdelivr.net/jquery.formvalidation/0.6.1/js/framework/bootstrap.min.js"></script>
        
        <script type="text/javascript" src="resources/formvalidation/dist/js/no_NO.js"></script>
        <title>Innlogging</title>
        <style>
         .form-group{
            width: 300px;
        }
        body{
            background-image: url("resources/images/Orange.png");
        }
        .tab-content{
            border-left: 1px solid #ddd;
            border-right:  1px solid #ddd;
            border-bottom:  1px solid #ddd;
            padding: 10px;
            width: 400px;
            min-height: 250px;
        }
        .nav-tabs{
            margin-bottom: 0;
            background-color: whitesmoke;
            border-top: 0px solid #ddd;
            width: 400px;
        }
        .btn-block {
            width: 300px;
        }
        #logintab{
            width: 133.3px;
        }
        #registertab{
            width: 133.3px;
        }
        #forgotpasswordtab{
            width: 133.3px;
        }
        .container {
            border: 1px solid black;
            border-radius: 10px;
            margin-top: 15px;
            margin-bottom: 15px; 
            min-height: 700px;
            width: 600px;
            background-color:  white;
            opacity: 0.85;
           }
        * {
            font-size: 100%;
            font-family: Century Gothic,CenturyGothic,AppleGothic,sans-serif;
            border-radius: 0 !important;
        }
        .error {
            color: #ff0000;
        }  
        </style>
    </head>
    <body> 
        <noscript>Denne nettsiden krever at JavaScript er aktivert.</noscript>
        <div class="container">
            <img src="<c:url value='/resources/images/MatistikkLogoSkriftBeskGjen.png'/>" id="MatistikkLogoSkriftBesk" 
                class="img-responsive center-block" width="600" height="300" alt="Responsive Image"/>
            <div id="lol">
                <center>
                    <!-- Tab panes -->             
                    <ul class="nav nav-tabs">
                        <li class="nav active" id="logintab"><a href="#A" data-toggle="tab">Innlogging</a></li>
                        <li class="nav" id="registertab"><a href="#B" data-toggle="tab">Registrering</a></li>
                        <li class="nav" id="forgotpasswordtab"><a href="#C" data-toggle="tab">Glemt passord</a></li>
                    </ul>

                    <!-- Tab panes content -->
                    <div class="tab-content">
                        <!--Login form-->
                        <div class="tab-pane fade in active" id="A"> 
                            <form:form role="form" id="login-form" action="login" method="POST" modelAttribute="userLogin">
                                <div class="form-group">
                                    <label>Brukernavn</label>
                                    <div class="input-group">
                                        <div class="input-group-addon"><i class="glyphicon glyphicon-user"></i></div>
                                        <input type="text" class="form-control" name="username" placeholder="E-post" autofocus>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>Passord</label>
                                    <div class="input-group">
                                        <div class="input-group-addon"><i class="glyphicon glyphicon-asterisk"></i></div>
                                        <input type="password" class="form-control" name="password" placeholder="Passord">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <h4><c:out value="${message}"/></h4>
                                </div>
                                <br>
                                <button type="submit" class="btn btn-success btn-block">Logg inn</button>
                            </form:form>
                        </div>
                        
                        <!--SignUp Form-->
                        <div class="tab-pane fade" id="B">
                            <form:form id="signup-form" action="newuser" method="POST" modelAttribute="student">
                                <div class="form-group">
                                    <label>Brukernavn</label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                        <input type="text" class="form-control" name="username" placeholder="E-post" autofocus >
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>Alder</label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-gift"></i></span>
                                        <input type="text" class="form-control" name="age" placeholder="Alder">
                                    </div>
                                </div>
                                <label class="radio-inline"><input type="radio" name="sex" value="true" checked="checked">Mann</label>
                                <label class="radio-inline"><input type="radio" name="sex" value="false">Dame</label>
                                <div>
                                    <br>
                                    <button type="submit" class="btn btn-primary">Registrer</button>
                                </div>
                            </form:form>
                        </div>
                        
                        <!--ForgotPassword form-->
                        <div class="tab-pane fade" id="C">
                            <form:form id="forgotPassword-form" action="forgotpassword" method="POST" modelAttribute="student">
                                <div class="form-group">
                                    <label>Brukernavn</label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                        <input type="text" class="form-control" name="username" placeholder="E-post" autofocus>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-primary">Send passord</button>
                            </form:form>
                        </div>
                    </div>
                </center>
            </div>
        </div>
                
        <script>
            $(document).ready(function() {
//                Validering av login-form
                $('#login-form').formValidation({
                    framework: 'bootstrap',
                    icon: {
                        valid: 'glyphicon glyphicon-ok',
                        invalid: 'glyphicon glyphicon-remove',
                        validating: 'glyphicon glyphicon-refresh'
                    },
                    locale: 'no_NO',
                    fields: {
                        username: {
                            validators: {
                                notEmpty: {
                                },
                                emailAddress: {
                                }
                            }
                        },
                        password: {
                            validators: {
                                notEmpty: {
                                },
                                stringLength: {
                                    min: 3,
                                    message: 'Vennligst fyll ut dette feltet med minst 3 tegn'
                                }
                            }
                        }
                    }
                });
//                Validering av signuup-form
                $('#signup-form').formValidation({
                    framework: 'bootstrap',
                    icon: {
                        valid: 'glyphicon glyphicon-ok',
                        invalid: 'glyphicon glyphicon-remove',
                        validating: 'glyphicon glyphicon-refresh'
                    },
                    locale: 'no_NO',
                    fields: {
                        username: {
                            validators: {
                                notEmpty: {
                                },
                                emailAddress: {
                                }
                            }
                        },
                        age: {
                            validators: {
                                notEmpty: {
                                },
                                numeric: {
                                }
                            }
                        }
                    }
                });
//                Validering av forgotPassword-form
                $('#forgotPassword-form').formValidation({
                    framework: 'bootstrap',
                    icon: {
                        valid: 'glyphicon glyphicon-ok',
                        invalid: 'glyphicon glyphicon-remove',
                        validating: 'glyphicon glyphicon-refresh'
                    },
                    locale: 'no_NO',
                    fields: {
                        username: {
                            validators: {
                                notEmpty: {
                                },
                                emailAddress: {
                                }
                            }
                        }
                    }
                });
            });
        </script>
    </body>
</html>