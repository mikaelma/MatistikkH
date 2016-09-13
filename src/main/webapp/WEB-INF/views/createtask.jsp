<%-- 
    Document   : createtask
    Author     : Team ENMAKA
--%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="no">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width= device-width, initial-scale = 1">
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
        <title>Oppgavetyper</title>
    </head>
    <body>
        <jsp:include page="/WEB-INF/views/menu.jsp"/>
        <jsp:include page="/WEB-INF/views/styling.jsp"/>
        <div class="container">
            <div class="jumbotron">
                <div class="page-header">
                    <center><h3>Brøk - Velg oppgavetype</h3></center>
                </div>
            </div>
            <center>
                <div class="col-lg-12">
                    <a class="btn btn-default" href="arithmeticview"><span style="font-size:10em;" class="glyphicon glyphicon-plus"></span><br>Aritmetikk</a>
                    <a class="btn btn-default" href="singlechoiceview"><span style="font-size:10em;" class="glyphicon glyphicon-check"></span><br>Velg riktig</a>
                    <a class="btn btn-default" href="sortview"><span style="font-size:10em;" class="glyphicon glyphicon-signal"></span><br>Rekkefølge</a>
                
                </div>
                <div class="col-lg-12">
                    <a class="btn btn-default" href="numberlineview"><span style="font-size:10em;" class="glyphicon glyphicon-tasks"></span><br>Tallinje</a>
                    <a class="btn btn-default" href="figuresview"><span style="font-size:10em;" class="glyphicon glyphicon-triangle-top"></span><br>Figurer</a>
                </div>
            <div class="col-lg-3"><a class="btn btn-primary btn-lg" href="choosetypeview">Tilbake</a></div>
            </center>
        </div>
        
            
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    </body>
</html>
