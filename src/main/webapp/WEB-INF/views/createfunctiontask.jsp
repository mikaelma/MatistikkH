<%--
    Document   : createfunctiontask
    Author     : Gruppe 6
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
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">       
        <title>Funksjoner</title>
        <!-- jQuery script -->
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script> 
        <!-- jQuery formvalidator script, sjekker etter gyldig inputs -->
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/3.51/jquery.form.js"></script>
        <!-- Bootstrap JavaScript-->
        <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
        <!-- JavaScript for embedded GeoGebra -->
        <script type="text/javascript" src="https://www.geogebra.org/scripts/deployggb.js"></script>
        <!-- Scriptet tar seg av logikken for infobokser plassert på siden-->
        <script type="text/javascript" src="resources/js/infoboxScript.js"></script> 
        <!-- Scriptet styrer mye av logikken bak createfunctiontask-viewet -->
        <script type="text/javascript" src="resources/js/createFunctionTaskScript.js"></script>
        <!-- Scriptet benyttes av infobokser og forhåndsvisning -->
        <script type="text/javascript" src="resources/js/modalScript.js"></script> 
        <!-- Scriptene som lager en grafisk presentasjon av LaTex kode -->
        <script type="text/x-mathjax-config">MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}});</script>
        <script type="text/javascript" async  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML"></script>
        <!-- Script for teksteditoren som benyttes på siden -->
        <script type="text/javascript" src="resources/ckeditor/ckeditor.js"></script>
        <!--Nøkkelen benyttes av CKeditor pluginet Uploadcare forå laste opp filer til kontoen-->
        <script>UPLOADCARE_PUBLIC_KEY = '255bcffadf120c92a388';</script>

    </head>
    <body>
        <jsp:include page="/WEB-INF/views/menu.jsp"/>
        <jsp:include page="/WEB-INF/views/styling.jsp"/>

        <form:form action="addfunctiontask" method="POST" modelAttribute="function" onsubmit ="validateButtons()"> 
           <div class="container">
                <div class="jumbotron">

                    <h3>Oppgave </h3>
                    <div id="questionGroup" class="panel-group">

                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">                            
                                    <a data-toggle="collapse" href="#collapseTaskText">Oppgavetekst</a>
                                    <span class="glyphicon glyphicon-question-sign" style="color:blue; float:right"></span>
                                </h4>
                            </div>
                            <div id="collapseTaskText" class="panel-collapse collapse in">
                                <div class="panel-body">  

                                    <form id ="questionForm">
                                        <textarea id="questionText" class ='form-control' style='min-width: 100%' name="text"></textarea>
                                        <script>CKEDITOR.replace('questionText', {toolbar: 'teacher'});</script>
                                        <input type="hidden" id="hidden7">
                                    </form>
                                    <input type="hidden" id="hidden7">
                                    <input type="hidden" id="hidden8">

                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default" id="geogebrapanel">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <label><input type="checkbox" id="geocheck" data-toggle="collapse" data-target="#collapseGeogebra" onclick="geogebraClick()" checked> Legg til Geogebra</label>
                                    <span class="glyphicon glyphicon-question-sign" style="color:blue; float:right"></span>
                                </h4>
                            </div>
                            <div id="collapseGeogebra" class="panel-collapse collapse in">
                                <div class="panel-body">              
                                    <div id="applet_container"></div>                            
                                </div>    
                                <input type="hidden" id="hidden4" name="geogebraString">  
                            </div>
                        </div>
                    </div>
                    <h3>Svar</h3>
                    <div id="accordion" class="panel-group" role="tablist">                
                        <div class="panel panel-default" id="tekstRadio">
                            <div class =" panel-heading" role="tab">
                                <h4 class="panel-title">
                                    <label><input type="radio" name="answer_type" value ="1" data-toggle="collapse" data-parent="#accordion" data-target="#collapse5" onclick="radioClick(this)" required>Tekstsvar</label>
                                    <span class="glyphicon glyphicon-question-sign" onclick="showtekstsvar()" style="color:blue; float:right; cursor: pointer"></span>
                                </h4>
                            </div>
                            <div id="collapse5" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <div>
                                        Hvis dette alternativet velges, vil eleven kunne gi et tekstlig svar
                                    </div>
                                </div>
                            </div>
                        </div>                

                        <div class="panel panel-default" id="flervalgRadio">
                            <div class="panel-heading" role="tab">
                                <h4 class="panel-title">
                                    <label><input type="radio" name="answer_type" value ="2" data-toggle="collapse" data-parent="#accordion" data-target="#collapse6" onclick="radioClick(this)">Flervalgstest</label>
                                    <span class="glyphicon glyphicon-question-sign" onclick="showflervalg()" style="color:blue; float:right; cursor: pointer"></span>
                                </h4>

                            </div>
                            <div id="collapse6" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <div class="form-group" id="fields">
                                        <label>Alternativ 1</label>
                                        <input type="text" class="form-control" id="alternativ1" placeholder="Alternativ 1" autofocus>
                                        <label>Alternativ 2</label>
                                        <input type="text" class="form-control" id="alternativ2" placeholder="Alternativ 2">
                                    </div>

                                    <input type="button" id="lessFields" onclick="removeFields()" value="-">
                                    <input type="button" id="moreFields" onclick="addFields()" value="+">
                                    <br>
                                    <hr>
                                    <label>Velg riktig alternativ</label>
                                    <br>
                                    <select id="dropdown">
                                        <option id="dropdown1">Alternativ 1</option>
                                        <option id="dropdown2">Alternativ 2</option>
                                    </select>
                                    <br>
                                    <input type="hidden" id="hidden1" name="solution">
                                    <input type="hidden" id="hidden2" name="functionString">
                                </div>
                            </div>
                        </div>

                        <div class="panel panel-default" id="geoRadio">
                            <div class =" panel-heading" role="tab">
                                <h4 class="panel-title">
                                    <label><input type="radio" name="answer_type" value ="3" data-toggle="collapse" data-parent="#accordion" data-target="#collapse7" onclick="radioClick(this)">Geogebra</label>
                                    <span class="glyphicon glyphicon-question-sign" onclick="showgeo()" style="color:blue; float:right; cursor: pointer"></span>

                                </h4>
                            </div>
                            <div id="collapse7" class="panel-collapse collapse">
                                <div class="panel-body">
                                    Hvis dette alternativet velges, vil eleven kunne svare kun med Geogebra. 
                                </div>
                            </div>
                        </div>

                        <div class="checkbox1 col-sm-offset-0" >
                            <input type="checkbox" name="explanation" id="explanation" value="1">
                            Tekstfelt for forklaring
                        </div>
                        <div class="checkbox2 col-sm-offset-0">
                            <input type="checkbox" name="drawing" id="drawing" value="2">
                            Mulighet for tegning
                        </div>

                        <div class="btn-group"><a class="btn btn-primary" href="choosetypeview">Tilbake</a>
                            <button type="button" id="forhandsbutton" class="btn btn-warning" onclick="setTekst(); showforhand()"><span class="glyphicon glyphicon-eye-open"></span> Forhåndsvisning</button>
                            <button type="submit" class="btn btn-success" onclick="setText(); putBase64();">Send inn oppgave</button>
                        </div>
                    </form:form>
                </div>                       
            </div>
        </div>   
    </body>
</html>
