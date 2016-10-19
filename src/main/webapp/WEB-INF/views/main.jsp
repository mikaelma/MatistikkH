<%-- 
    Document   : main
    Author     : Team ENMAKA
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="no">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width= device-width, initial-scale = 1">
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"> 
        <title>Hovedside</title>
         <!link href='https://fonts.googleapis.com/css?family=Pacifico' rel='stylesheet' type='text/css'>
         <style>
            .navbar-default {
                border-radius: 5px;
            }
         </style>
    </head>
    <body>
        <jsp:include page="/WEB-INF/views/styling.jsp"/>
        <jsp:include page="/WEB-INF/views/menu.jsp"/>
        <div class="container">
            <div class="page-header">
                <center><h1>Velkommen til Matistikk!</h1></center>
            </div>
            <c:if test="${sessionScope.user.description == 'Student'}">
                <div class="jumbotron">
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                            <p>Ved å klikke på den grønne pilen til høyre vil du komme til de testene som er tilgjengelig for deg.</p>
                            <p>Hvis du enda ikke har gjort det bør du gå inn på "Min side", og registrere din klasses unike kode, 
                                slik at du får tilgang til alle testene som er publisert for din klasse.</p>
                            <h3>Lykke til!</h3>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                            <center><a class="btn btn-default" style="color:green; position: relative;" href="testview" id="totestarrow">
                                <span style="font-size:20em;" class="glyphicon glyphicon-arrow-right"></span>
                                <span class='centered-text'>Til testene</span>
                                </a></center>
                        </div>
                    </div>
                </div>
            </c:if>
            
            <c:if test= "${sessionScope.user.description == 'Teacher'}">
                <div class="jumbotron">
                    <p>Som lærer kan du lage øvingstester som du kan gi til dine elever. Det kan gjøres ved å trykke på "Lag Øvingstest" under,
                    eller i menylinjen.</p>
                    <p>Du kan ogse se statistikken for de øvingstestene du har laget. Denne statistikken kan åpnes ved å klikke "Statistikk"
                    under, eller i menylinjen.</p>
                    <br>
                    <center>
                        <div class="btn-group" role="group" aria-label="...">
                            <a style="width: 130px" type="button" class="btn btn-primary" href="createtestview">Lag Øvingstest</a>
                            <a style="width: 130px" type="button" class="btn btn-primary" href="statisticview">Statistikk</a>
                            
                        </div>
                        <br>
                        <br>
                        <c:if test="${publishTests == true}"><h4 style="font-weight: bold">Du har upubliserte tester!</h4>
                            <a style="width: 260px" type="button" class="btn btn-success" href="publishtests"><h4>Publiser tester</h4></a>
                        </c:if>
                    </center>
                </div>
            </c:if>
            
            <c:if test= "${sessionScope.user.description == 'Admin'}">
                <div class="jumbotron">
                    <p>Som admin har du tilgang til den fulle brukeroversikten. Den kan aksesseres ved å trykke på "Brukeroversikt" under,
                    eller i menylinjen. Du har da muligheten til å legge til nye lærere, eller slette gamle.</p>
                    <p>Du kan ogse se hele statistikken for denne nettsidens tester. Denne statistikken kan åpnes ved å klikke "Statistikk"
                    under, eller i menylinjen.</p>
                    <br>
                    <center>
                        <div class="btn-group" role="group" aria-label="...">
                            <a style="width: 130px" type="butoon" class="btn btn-primary" href="alltests">Testoversikt</a>
                            <a style="width: 130px" type="button" class="btn btn-primary" href="getallusers">Brukeroversikt</a>
                            <a style="width: 130px" type="butoon" class="btn btn-primary" href="allschools">Skoleoversikt</a>
                            <br>
                            <a style="width: 130px" type="butoon" class="btn btn-primary" href="mypageview">Min side</a>
                            <a style="width: 130px" type="butoon" class="btn btn-primary" href="createtestview">Lag Test</a>
                            <a style="width: 130px" type="button" class="btn btn-primary" href="statisticview">Statistikk</a>
                        </div>
                    </center>
                </div>
            </c:if>
        </div>
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    </body>
</html>
