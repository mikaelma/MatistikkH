<%-- 
    Document   : taskstatisticsmore
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
        <meta name="viewport" content="width= device-witdh, initial-scale = 1">
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"> 
        <title>Oppgave <c:out value="${taskId}" /></title>
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
                <h4>Page Header</h4>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    Oppgave <c:out value="${taskId}" />
                </div>
                <div class="panel-body">
                    <p>Svar</p>
                    <hr>
                    <p>Forklaring/begrunnelse</p>
                    <hr>
                    <p>Tegning</p>
                    
                </div>
                <div class="panel-footer">
                    Footer
                </div>
            </div>
        </div>
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    </body>
</html>
