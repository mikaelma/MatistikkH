<%-- 
    Document   : help
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
        <title>Hjelp</title>
    </head>
    <body>
        <jsp:include page="/WEB-INF/views/styling.jsp"/>
        <jsp:include page="/WEB-INF/views/menu.jsp" />
        <div class="container">
            <div class="page-header">
                <center><h1>Trenger du hjelp?</h1></center>
            </div>
            <c:if test= "${user.description == 'Student'}">
            <div class="jumbotron ">
                <p>For å begynne på en test må du trykke på "Tester" øverst i menylinjen, eller gå til startsiden hvor du vil se en stor grønn pil som vil ta deg til de tilgjengelige testene.
  
                </p>
                </div>
            </c:if>
            <c:if test= "${user.description == 'Teacher'}">
            <div class="jumbotron ">
                <p>På hjemmesiden vil du få et varsel dersom du har fått utdelt tester som du ennå ikke har publisert. 
                   Du har også muligheten for å opprette egne øvingstester ved å klikke på "Lag Øvingstest". Disse testene deles automatisk ut til klassene du har ansvar for.
                   
                </div>
            </c:if>
            <c:if test= "${user.description == 'Admin'}">
            <div class="jumbotron ">
                <p>Du kan som admin opprette tester ved å klikke på linken "Lag Test".
                   Du velger da hvilke oppgaver som skal være med i testen og hvilke lærere som skal få ansvar for å publisere testene til klassene sine.
                   Ved å klikke på "Oversikt" vil du kunne vise bruker-, skole- og testoversikt. 
                   "Statistikk" lar deg se de statistiske dataene fra tester du har opprettet, og du har også mulighet for å eksportere disse dataene.
                </div>
            </c:if>
        </div>
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    </body>
</html>
