<%-- 
    Document   : Validator
    Created on : 22.mai.2016, 00:28:06
    Author     : magnussj
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Bootstrap CSS v3.0.0 or higher -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">

        <!-- FormValidation CSS file -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/jquery.formvalidation/0.6.1/css/formValidation.min.css">

        <!-- jQuery v1.9.1 or higher -->
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>

        <!-- Bootstrap JS -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

        <!-- FormValidation plugin and the class supports validating Bootstrap form -->
        <script src="https://cdn.jsdelivr.net/jquery.formvalidation/0.6.1/js/formValidation.min.js"></script>
        <script src= "https://cdn.jsdelivr.net/jquery.formvalidation/0.6.1/js/framework/bootstrap.min.js"></script>>
        
        <script type="text/javascript" src="resources/formvalidation/dist/js/no_NO.js"></script>
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container">
            <form id="registrationForm" method="post" class="form-horizontal">
                <div class="form-group">
                    <label class="col-xs-3 control-label">Username</label>
                    <div class="col-xs-5">
                        <input type="text" class="form-control" name="username" />
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-xs-3 control-label">Email address</label>
                    <div class="col-xs-5">
                        <input type="text" class="form-control" name="email" />
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-xs-3 control-label">Password</label>
                    <div class="col-xs-5">
                        <input type="password" class="form-control" name="password" />
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-xs-3 control-label">Gender</label>
                    <div class="col-xs-5">
                        <div class="radio">
                            <label>
                                <input type="radio" name="gender" value="male" /> Male
                            </label>
                        </div>
                        <div class="radio">
                            <label>
                                <input type="radio" name="gender" value="female" /> Female
                            </label>
                        </div>
                        <div class="radio">
                            <label>
                                <input type="radio" name="gender" value="other" /> Other
                            </label>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-xs-3 control-label">Date of birth</label>
                    <div class="col-xs-5">
                        <input type="text" class="form-control" name="birthday" placeholder="YYYY/MM/DD" />
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-xs-9 col-xs-offset-3">
                        <button type="submit" class="btn btn-default">Sign up</button>
                    </div>
                </div>
            </form>

            <script>
            $(document).ready(function() {
                $('#registrationForm').formValidation({
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
                                stringLength: {
                                    min: 6,
                                    max: 30
                                },
                                regexp: {
                                    regexp: /^[a-zA-Z0-9]+$/
                                }
                            }
                        },
                        email: {
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
                                    min: 8
                                }
                            }
                        },
                        birthday: {
                            validators: {
                                notEmpty: {
                                },
                                date: {
                                    format: 'YYYY/MM/DD'
                                }
                            }
                        },
                        gender: {
                            validators: {
                                notEmpty: {
                                }
                            }
                        }
                    }
                });
            });
            </script>
        </div>
    </body>
</html>
