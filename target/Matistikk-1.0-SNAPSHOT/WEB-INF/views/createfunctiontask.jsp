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
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="">
        <title>Funksjoner</title>
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
                                </h4>
                            </div>
                            <div id="collapseTaskText" class="panel-collapse collapse in">
                                <div class="panel-body">   

                                    <form id ="questionForm">
                                        <textarea id="questionText" class ='form-control' style='min-width: 100%' name="text" required></textarea>
                                    </form>

                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <a data-toggle="collapse" href="#collapsePicUpload">Legg til bilde</a>
                                </h4>
                            </div>
                            <div id="collapsePicUpload" class="panel-collapse collapse">
                                <div class="panel-body">    
                                    <form id="UploadForm" action="upload" method="post" enctype="multipart/form-data" runat="server">
                                        <input type="file" id="myFile" name="photo" onchange="readImage(this);" accept="image/*"/>                                          
                                        <img id="myFilePreview" src="#" alt="valgt bilde"/><br>
                                        <input class="btn btn-success btn-lg" type="submit" value="Last opp fil" />
                                    </form>                                                              
                                </div>
                            </div>
                        </div>                               
                        <div class="panel panel-default">
                            <div class =" panel-heading">
                                <a data-toggle="collapse" href="#collapse2">Legg til GeoGebra</a>
                            </div>
                            <div id="collapse2" class="panel-collapse collapse">
                                <div class="panel-body" style='max-width: 100%'>
                                    <div id="applet_container"></div>
                                </div>
                            </div>
                        </div>
                    </div>                        
                    <h3>Svar</h3>
                    <div  id="accordion" class="panel-group" role="tablist">                

                        <div class="panel panel-default">
                            <div class =" panel-heading" role="tab">
                                <h4 class="panel-title">
                                    <label><input type="radio" name="answer_type" value ="1" data-toggle="collapse" data-parent="#accordion" data-target="#collapse5" required>Tekstsvar</label>
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


                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab">
                                <h4 class="panel-title">
                                    <label><input type="radio" name="answer_type" value ="2" data-toggle="collapse" data-parent="#accordion" data-target="#collapse6">Flervalgstest</label>
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
                                    <br>
                                    <select id="dropdown">
                                        <option value="alternativ1">Alternativ 1</option> 
                                        <option value="alternativ2">Alternativ 2</option>
                                    </select>
                                    <br>
                                    <input type="hidden" id="hidden1" name="text">
                                    <input type="hidden" id="hidden2" name="fractionsString">
                                </div>
                            </div>
                        </div>

                        <div class="panel panel-default">
                            <div class =" panel-heading" role="tab">
                                <h4 class="panel-title">
                                    <label><input type="radio" name="answer_type" value ="3" data-toggle="collapse" data-parent="#accordion" data-target="#collapse7">Geogebra</label>
                                </h4>
                            </div>
                            <div id="collapse7" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <div class="panel-body" style='max-width: 100%'>
                                        <div id="applet_container"></div>
                                    </div>
                                </div>
                            </div> 
                        </div>


                        <div class="checkbox col-sm-offset-0" >
                            <label>
                                <input type="checkbox">Tekstfelt for forklaring</label>
                        </div>
                        <div class="checkbox col-sm-offset-0">
                            <label>
                                <input type="checkbox">Mulighet for tegning</label>
                        </div>

                        <div class="btn-group"><a class="btn btn-primary" href="choosetypeview">Tilbake</a>
                            <button class="btn btn-warning"><span class="glyphicon glyphicon-eye-open"></span> Forhåndsvisning</button>
                            <button type="submit" class="btn btn-success">Send inn oppgave</button>
                        </div>
                        </form:form> 
                </div> 

            </div>
        </div>

        <script>
            function readImage(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#myFile')
                                .attr('src', e.target.result)
                                .width(150)
                                .height(200);
                    };
                    reader.readAsDataURL(input.files[0]);
                }
            }
        </script>
        <script>
            function validateButtons(){
                var r = document.getElementsByName("answer_type");
                var c = -1;
                
                for(var i = 0; i<r.length; i++){
                    if(r[i].checked){
                        c=i;
                    }
                }
                if(c === -1){
                    alert ("Velg et svaralternativ");
                    location.reload();
            }
        }
        </script>

        <script>
            var counter = 3;
            function addFields() {
                document.getElementById('dropdown').innerHTML = "";
                
                document.getElementById('fields').innerHTML += '<label id="label' + counter + '">Alternativ ' + counter +
                        '</label> <input type="text" class="form-control" id="alternativ' + counter + '" placeholder="Alternativ ' + counter + ' " required>';
                
                
                for(var i=0; i<counter; i++){
                   document.getElementById('dropdown').innerHTML += '<option value="alternativ' + (i+1) + '">Alternativ ' + (i+1) + '</option>'; 
                }
                
                counter++;
                
            }

            function removeFields() {
                document.getElementById('dropdown').innerHTML = "";
                var something = (counter - 1);
                if (something == 2) {
                    document.getElementById('dropdown').innerHTML += '<option value="alternativ1">Alternativ 1</option> <option value="alternativ2">Alternativ 2</option>';
                    return false;
                }
                
                for(var i=0; i<(something-1); i++){
                   document.getElementById('dropdown').innerHTML += '<option value="alternativ' + (i+1) + '">Alternativ ' + (i+1) + '</option>'; 
                }
                
                counter--;
                var element2 = document.getElementById('label' + counter);
                element2.parentNode.removeChild(element2);
                var element3 = document.getElementById('alternativ' + counter);
                element3.parentNode.removeChild(element3);
            }
            function setText() {
                var x = document.getElementById('question').value + ' ' + document.getElementById('numerator1').value + '/' + document.getElementById('denominator1').value + ' ' + document.getElementById('options1').value + ' ' + document.getElementById('numerator2').value + '/' + document.getElementById('denominator2').value;
                for (i = 3; i < counter; i++) {
                    var j = i - 1;
                    x += ' ' + document.getElementById('options' + j).value + ' ' + document.getElementById('numerator' + i).value + '/' + document.getElementById('denominator' + i).value;
                }

                document.getElementById('hidden').value = x + '?';
            }
        </script>


        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
        <script>
            window.onload = function () {
                document.getElementById("questionText").onkeyup = checkWordCount;
                checkWordCount();
            };

            function checkWordCount() {
                var savebtn = document.getElementById("saveText");
                if (document.getElementById("questionText").value == "") {
                    savebtn.disabled = true;
                    savebtn.style.backgroundColor = "#ff0000";
                } else {

                    savebtn.disabled = false;
                    savebtn.style.backgroundColor = "#00cc00";
                }
            }
        </script>
        <script>
            function readImage(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#myFilePreview')
                                .attr('src', e.target.result)
                                .width(150)
                                .height(200);
                    };
                    reader.readAsDataURL(input.files[0]);
                }
            }
        </script>

        <script type="text/javascript" src="https://www.geogebra.org/scripts/deployggb.js"></script>
        <script type="text/javascript">

            var parameters = {"prerelease": false, "showToolBar": true, "borderColor": null, "showMenuBar": true, "showAlgebraInput": false,
                "showResetIcon": true, "enableLabelDrags": false, "enableShiftDragZoom": true, "enableRightClick": false, "capturingThreshold": null, "showToolBarHelp": false,
                "errorDialogsActive": true, "useBrowserForJS": false};
            var applet = new GGBApplet('5.0', parameters);
            applet.setJavaCodebase('GeoGebra/Java/5.0');
            window.onload = function () {
                applet.inject('applet_container', 'preferHTML5');
            }


        </script>
    </body>
</html>
