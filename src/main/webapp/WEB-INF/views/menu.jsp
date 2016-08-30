<%-- 
    Document   : menu
    Author     : Team ENMAKA
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--Navbar student-->
<c:if test= "${sessionScope.user.description == 'Student'}">
    <nav class="navbar navbar-inverse">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" 
                    data-target="#mynavbar">
                    <span class="sr-only"></span>  
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="pull left" href="home"><img src="<c:url value='/resources/images/MatistikkSkrift.png'/>" width="240" height="50" alt="Home"/></a>
            </div>
            <div class="navbar-collapse collapse" id="mynavbar">
                <ul class="nav navbar-nav">

                    <li><a href="home"><span class="glyphicon glyphicon-home "></span></a></li>
                    <li><a href="mypageview">Min Side</a></li>
                    <li><a href="testview">Tester</a></li>
                    <li><a href="helpview">Hjelp</a></li>
                    <li><a href="aboutview">Om</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li><a>Logget inn som: ${sessionScope.user.username}</a></li>
                    <li><a href="logout"><span class="glyphicon glyphicon-log-out"></span>Logg ut</a></li>
                </ul>
            </div>
        </div>
    </nav>
</c:if>

<!--Navbar lærer-->
<c:if test= "${sessionScope.user.description == 'Teacher'}">
    <nav class="navbar navbar-inverse">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" 
                    data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="pull left" href="home"><img src="<c:url value='/resources/images/MatistikkSkrift.png'/>" width="240" height="50"/></a>
            </div>
            <div class="navbar-collapse collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li><a href="home"><span class="glyphicon glyphicon-home "></span></a></li>
                    <li><a href="mypageview">Min Side</a></li>
                    <li><a href="createtestview">Lag Øvingstest</a></li>
                    <li><a href="statisticview">Statistikk</a></li>
                    <li><a href="edittests">Rediger mine tester</a>
                    <li><a href="helpview">Hjelp</a></li>
                    <li><a href="aboutview">Om</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li><a>Logget inn som: ${sessionScope.user.username}</a></li>
                    <li><a href="logout"><span class="glyphicon glyphicon-log-out"></span>Logg ut</a></li>
                </ul>
            </div>
        </div>
    </nav>
</c:if>

<!--Navbar admin-->
<c:if test= "${sessionScope.user.description == 'Admin'}">
    <nav class="navbar navbar-inverse">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" 
                    data-target="#navbar">
                    <span class="sr-only"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="pull left" href="home"><img src="<c:url value='/resources/images/MatistikkSkrift.png'/>" width="240" height="50"/></a>
            </div>
            <div class="navbar-collapse collapse" id="navbar">
                <ul class="nav navbar-nav">
                    <li><a href="home"><span class="glyphicon glyphicon-home "></span></a></li>
                    <li><a href="mypageview">Min Side</a></li>
                    <li><a href="createtestview">Lag Test</a></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Oversikt <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="getallusers">Brukeroversikt</a></li>
                            <li><a href="allschools">Skoleoversikt</a></li>
                            <li><a href="alltests">Testoversikt</a></li>
                        </ul>
                    </li>
                    <li><a href="statisticview">Statistikk</a></li>
                    <li><a href="helpview">Hjelp</a></li>

                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li><a>Logget inn som: ${sessionScope.user.username}</a></li>
                    <li><a href="logout"><span class="glyphicon glyphicon-log-out"></span>Logg ut</a></li>
                </ul>
            </div>
        </div>
    </nav>
</c:if>