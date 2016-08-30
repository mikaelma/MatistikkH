<%-- 
    Document   : figures
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
        <title>Figur oppgave</title>
        <style>
            #numerator1, #numerator2{
                width: 55px;
                height: 30px;
                padding:0; 
                margin:0 
            }
            #denominator1, #denominator2{
                width: 55px;
                height: 30px;
                padding:0; 
                margin:0 
            }
            .container{
                height: 910px !important;
            }
            input::-webkit-outer-spin-button,
            input::-webkit-inner-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }
        </style>
            
    </head>
    <body>
        <jsp:include page="/WEB-INF/views/menu.jsp"/>
        <jsp:include page="/WEB-INF/views/styling.jsp"/>
        <div class="container">
            <div class="jumbotron">
                <div class="page-header">
                    <p class="text-center">Oppgave av typen Figur</p>
                </div>
                <form:form action="addfigurestask" method="POST" modelAttribute="figures" id="figures">
                    <div class="form-group" id="fields1">
                        
                        <center>
                        <div class="col-lg-12">
                            
                            <img src="<c:url value='/resources/images/figures/1div6.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setSelected('1div6')" id="1div6"/>
                            <img src="<c:url value='/resources/images/figures/1div5.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setSelected('1div5')" id="1div5"/>
                            <img src="<c:url value='/resources/images/figures/1div4.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setSelected('1div4')" id="1div4"/>
                            <img src="<c:url value='/resources/images/figures/1div3.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setSelected('1div3')" id="1div3"/>
                            <img src="<c:url value='/resources/images/figures/2div5.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setSelected('2div5')" id="2div5"/>
                            <img src="<c:url value='/resources/images/figures/1div2.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setSelected('1div2')" id="1div2"/>
                        <div class="col-lg-12">
                            <img src="<c:url value='/resources/images/figures/3div5.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setSelected('3div5')" id="3div5"/>
                            <img src="<c:url value='/resources/images/figures/2div3.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setSelected('2div3')" id="2div3"/>
                            <img src="<c:url value='/resources/images/figures/3div4.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setSelected('3div4')" id="3div4"/>
                            <img src="<c:url value='/resources/images/figures/4div5.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setSelected('4div5')" id="4div5"/>
                            <img src="<c:url value='/resources/images/figures/5div6.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setSelected('5div6')" id="5div6"/>
                            <img src="<c:url value='/resources/images/figures/2div2.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setSelected('2div2')" id="2div2"/>
                        </div>
                        
                        </center>
                        <center>
                        <span id="selectederror"></span>
                        </center>
                        <br>
                        <div class="col-lg-12">
                        <input type="text" class="form-control" id="question1" value="Denne figuren representerer" required/><br>
                        <div class="form-group">
                            <input type="number" id="numerator1" placeholder="Teller" required> /
                            <input type="number" id="denominator1" placeholder="Nevner" required/>
                        </div>
                            <br>
                            <input type="text" class="form-control" id="question2" value="Velg da hvilken figur som representerer" required/>
                            <br>
                            <div class="form-group">
                                <input type="number" id="numerator2" placeholder="Teller" required/> /
                                <input type="number" id="denominator2" placeholder="Nevner" required/>
                            </div>
                        </div>
                        <center>
                        <label>Velg riktig svar her:</label>
                        <div class="form-group">
                            <span id="answererror"></span>
                        <div class="col-lg-12">
                            <img src="<c:url value='/resources/images/figures/1div6.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setAnswer('1div6A')" id="1div6A"/>
                            <img src="<c:url value='/resources/images/figures/1div5.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setAnswer('1div5A')" id="1div5A"/>
                            <img src="<c:url value='/resources/images/figures/1div4.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setAnswer('1div4A')" id="1div4A"/>
                            <img src="<c:url value='/resources/images/figures/1div3.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setAnswer('1div3A')" id="1div3A"/>
                            <img src="<c:url value='/resources/images/figures/2div5.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setAnswer('2div5A')" id="2div5A"/>
                            <img src="<c:url value='/resources/images/figures/1div2.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setAnswer('1div2A')" id="1div2A"/>
                        <div class="col-lg-12">
                            <img src="<c:url value='/resources/images/figures/3div5.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setAnswer('3div5A')" id="3div5A"/>
                            <img src="<c:url value='/resources/images/figures/2div3.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setAnswer('2div3A')" id="2div3A"/>
                            <img src="<c:url value='/resources/images/figures/3div4.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setAnswer('3div4A')" id="3div4A"/>
                            <img src="<c:url value='/resources/images/figures/4div5.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setAnswer('4div5A')" id="4div5A"/>
                            <img src="<c:url value='/resources/images/figures/5div6.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setAnswer('5div6A')" id="5div6A"/>
                            <img src="<c:url value='/resources/images/figures/2div2.png'/>" style="width: 100px; height: 100px; border: 1px solid #aaaaaa;" onclick="setAnswer('2div2A')" id="2div2A"/>
                        </div>
                            </center>
                        <br>
                        <br>
                        <a class="btn btn-primary" href="createtaskview" style="float: left">Tilbake</a>
                        <button type="submit" class="btn btn-success"  onclick="setText()">Legg til</button>
                        <input type="hidden" id="hidden1" name="figureUrl"/>
                        <input type="hidden" id="hidden2" name="text"/>
                        <input type="hidden" id="hidden3" name="solutionUrl"/>
                        </div>
                        </div> 
                 </div> 
                        
                          
                        
                    </div>
                </form:form>
            </div>
        </div>
    </center>
    </body>
    
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
        <script>
            var selected = '';
            var answer = '';
            function setSelected(e){
                if(selected == ''){
                    document.getElementById(e).style.border = "medium solid #00FF00";
                }else{
                    document.getElementById(selected).style.border = "1px solid #aaaaaa";
                    document.getElementById(e).style.border = "medium solid #00FF00";
                }
                selected = e;
                document.getElementById("hidden1").value = document.getElementById(selected).src;
            }
            
            function setAnswer(e){
                if(answer == ''){
                    document.getElementById(e).style.border = "medium solid #00FF00";
                }else{
                    document.getElementById(answer).style.border = "1px solid #aaaaaa";
                    document.getElementById(e).style.border = "medium solid #00FF00";
                }
                answer = e;
                document.getElementById("hidden3").value = answer;
            }
            function setText(){
                document.getElementById("hidden2").value = document.getElementById("question1").value + " " + document.getElementById("numerator1").value + "/" + document.getElementById("denominator1").value + ". " + document.getElementById("question2").value + ' ' +
                                                           document.getElementById("numerator2").value + "/" + document.getElementById("denominator2").value + ". ";
            }
            
            document.getElementById("figureform").onsubmit = function(){
                if(selected == ''){
                    document.getElementById("selectederror").innerHTML = "Du må velge en figur";
                    return false;
                }
                if(answer == ''){
                    document.getElementById("answererror").innerHTML = "Du må velge en figur";
                    return false;
                }
                return true;
            };
        </script>
</html>
