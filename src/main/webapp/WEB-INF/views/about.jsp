<%-- 
    Document   : about
    Author     : Team ENMAKA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width= device-witdh, initial-scale = 1">
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"> 
        <title>Om Matistikk</title>
    </head>
    <body>
        <jsp:include page="/WEB-INF/views/styling.jsp"/>
        <jsp:include page="/WEB-INF/views/menu.jsp" />
        <div class="container">
            <div class="page-header">
                    <center><h1>Litt om Matistikk</h1></center>
                </div>
            <div class="jumbotron ">
                <p>Dette er en nettside med hensikt å samle inn data om tankegangen til elever når de løser brøkoppgaver.
                   Nettsiden er utviklet i sammenheng med en Bacheloroppgave på Dataingeniør-linja ved NTNU våren 2016.
                   Oppgaven ble stilt av NTNUs fakultet for lærer- og tolkeutdanning som en måte å forbedre innsamling av data om tankegang i forhold til forskning.
                </p>
            </div>
        </div>
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    </body>
</html>
