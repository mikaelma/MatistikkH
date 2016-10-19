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
        <script type="text/javascript" src="http://code.jquery.com/jquery-1.8.2.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/3.51/jquery.form.js"></script>
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
                                        <textarea id="questionText" class ='form-control' style='min-width: 100%' name="text" required></textarea>
                                    </form>

                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <a data-toggle="collapse" href="#collapsePicUpload">Legg til bilde</a>
                                    <span class="glyphicon glyphicon-question-sign" style="color:blue; float:right"></span>
                                </h4>
                            </div>
                            <div id="collapsePicUpload" class="panel-collapse collapse">
                                <div class="panel-body">              
                                    <label class="inline">
                                        <input type="file" id="myFile" name="file" onchange="readImage(this);" accept="image/*"/>                                          
                                        <img id="myFilePreview" src="#" alt="valgt bilde"/><br>
                                    </label>
                                    <div id="upload" style="display: none;">Laster opp..</div>
                                    <div id="message"></div>
                                    <input type="hidden" id="url" name="url">                                
                                </div>                                                              
                            </div>
                        </div>
                                                 
                    <div class="panel panel-default">
                        <div class =" panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse2">Legg til GeoGebra</a>
                                <span class="glyphicon glyphicon-question-sign" style="color:blue; float:right"></span>
                            </h4>
                        </div>
                        <div id="collapse2" class="panel-collapse collapse">
                            <div class="panel-body" style='max-width: 100%'>
                                <div id="applet_container"></div>
                            </div>
                        </div>
                    </div>
                    </div>
                    <h3>Svar</h3>
                    <div id="accordion" class="panel-group" role="tablist">                
                        <div class="panel panel-default">
                            <div class =" panel-heading" role="tab">
                                <h4 class="panel-title">
                                    <label><input type="radio" name="answer_type" value ="1" data-toggle="collapse" data-parent="#accordion" data-target="#collapse5" required>Tekstsvar</label>
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

                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab">
                                <h4 class="panel-title">
                                    <label><input type="radio" name="answer_type" value ="2" data-toggle="collapse" data-parent="#accordion" data-target="#collapse6">Flervalgstest</label>
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

                        <div class="panel panel-default">
                            <div class =" panel-heading" role="tab">
                                <h4 class="panel-title">
                                    <label><input type="radio" name="answer_type" value ="3" data-toggle="collapse" data-parent="#accordion" data-target="#collapse7">Geogebra</label>
                                    <span class="glyphicon glyphicon-question-sign" onclick="showgeo()" style="color:blue; float:right; cursor: pointer"></span>

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

                        <div class="checkbox1 col-sm-offset-0" >
                            <input type="checkbox" name="explanation" id="explanation" value="1">
                            Tekstfelt for forklaring
                        </div>
                        <div class="checkbox2 col-sm-offset-0">
                            <input type="checkbox" name="drawing" id="drawing" value="2">
                            Mulighet for tegning
                        </div>

                        <div class="btn-group"><a class="btn btn-primary" href="choosetypeview">Tilbake</a>
                            <button type="button" class="btn btn-warning" onclick="showforhand()"><span class="glyphicon glyphicon-eye-open"></span> Forhåndsvisning</button>
                            <button type="submit" class="btn btn-success" onclick="setText()">Send inn oppgave</button>
                        </div>
                    </form:form>
                </div>

            </div>
        </div>

        <script type="text/javascript">
            var showgeo = function () {
                jQuery(function ($) {
                    $('body').bsMsgBox({
                        title: "Geogebra",
                        text: "Velg dette alternativet dersom du ønsker at eleven skal svare med Geogebra",
                        icon: 'info'
                    });
                });
            };

            var showflervalg = function () {
                jQuery(function ($) {
                    $('body').bsMsgBox({
                        title: "Flervalgstest",
                        text: "Velg dette alternativet dersom du ønsker at eleven skal svare med flervalgstest"
                                + "<hr> Skriv inn svaralternativene i disse feltene:<br>"
                                + "<img src='<c:url value='/resources/images/alternativ.png'/>' alt='alternativ'>"
                                + "<hr> Trykk pluss eller minus for å legge til eller fjerne et alternativ:<br>"
                                + "<img src='<c:url value='/resources/images/plussminus.png'/>' alt='plussminus'>"
                                + "<hr> Velg svaralternativet som er det korrekte i denne dropdownlisten:<br>"
                                + "<img src='<c:url value='/resources/images/velgalternativ.png'/>' alt='velgalternativ'>",
                        icon: 'info'
                    });
                });
            };

            var showtekstsvar = function () {
                jQuery(function ($) {
                    $('body').bsMsgBox({
                        title: "Tekstsvar",
                        text: "Velg dette alternativet dersom du ønsker at eleven skal svare med tekstsvar",
                        icon: 'info'
                    });
                });
            };


        </script>

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
            var counter = 3;
            function addFields() {
                if (counter == 10) {
                    alert('Du kan maks ha 9 svaralternativer');
                }


                if (counter < 10) {
                    document.getElementById('dropdown').innerHTML = "";

                    document.getElementById('fields').innerHTML += '<label id="label' + counter + '">Alternativ ' + counter +
                            '</label> <input type="text" class="form-control" id="alternativ' + counter + '" placeholder="Alternativ ' + counter + ' " required>';

                    for (var i = 0; i < counter; i++) {
                        document.getElementById('dropdown').innerHTML += '<option id="dropdown' + (i + 1) + '">Alternativ ' + (i + 1) + '</option>';

                    }

                    counter++;
                }
            }

            function removeFields() {
                document.getElementById('dropdown').innerHTML = "";
                var something = (counter - 1);
                if (something == 2) {
                    document.getElementById('dropdown').innerHTML += '<option id="dropdown1">Alternativ 1</option> <option id="dropdown2">Alternativ 2</option>';
                    return false;
                }

                for (var i = 0; i < (something - 1); i++) {
                    document.getElementById('dropdown').innerHTML += '<option id="dropdown' + (i + 1) + '">Alternativ ' + (i + 1) + '</option>';

                }

                counter--;
                var element2 = document.getElementById('label' + counter);
                element2.parentNode.removeChild(element2);
                var element3 = document.getElementById('alternativ' + counter);
                element3.parentNode.removeChild(element3);
            }
            function setText() {
                document.getElementById("hidden2").value = document.getElementById("alternativ1").value + "|||" + document.getElementById("alternativ2").value;
                for (i = 3; i < counter; i++) {
                    document.getElementById("hidden2").value += '|||' + document.getElementById('alternativ' + i).value;
                }

                document.getElementById("hidden1").value = document.getElementById("dropdown").value;
            }

            var showforhand = function () {
                jQuery(function ($) {
                    var text = $('textarea#questionText').val();
                    var valg = $("input:radio[name ='answer_type']:checked").val();
                    var src = $('#myFilePreview').attr('src');

                    var answerfield = "";
                    if (valg == 1) {
                        answerfield = "<textarea style='min-width: 100%; resize:none'></textarea>";
                    }
                    if (valg == 2) {
                        var alternativ1 = $('#alternativ1').val();
                        var alternativ2 = $('#alternativ2').val();
                        var alternativ3 = $('#alternativ3').val();
                        var alternativ4 = $('#alternativ4').val();
                        var alternativ5 = $('#alternativ5').val();
                        var alternativ6 = $('#alternativ6').val();
                        var alternativ7 = $('#alternativ7').val();
                        var alternativ8 = $('#alternativ8').val();
                        var alternativ9 = $('#alternativ9').val();

                        answerfield = "<input type='radio' name='options'>" + alternativ1 + "<br><input type='radio' name='options'>" + alternativ2;

                        for (var i = 3; i < counter; i++) {
                            if (i == 3) {
                                answerfield += "<br><input type='radio' name='options'>" + alternativ3;
                            } else if (i == 4) {
                                answerfield += "<br><input type='radio' name='options'>" + alternativ4;
                            } else if (i == 5) {
                                answerfield += "<br><input type='radio' name='options'>" + alternativ5;
                            } else if (i == 6) {
                                answerfield += "<br><input type='radio' name='options'>" + alternativ6;
                            } else if (i == 7) {
                                answerfield += "<br><input type='radio' name='options'>" + alternativ7;
                            } else if (i == 8) {
                                answerfield += "<br><input type='radio' name='options'>" + alternativ8;
                            } else if (i == 9) {
                                answerfield += "<br><input type='radio' name='options'>" + alternativ9;
                            }
                        }
                    }

                    if ($('#explanation').is(":checked")) {
                        answerfield += "<br><br><label>Forklaring</label><br><textarea style='min-width: 100%; resize:none'></textarea>";
                    }

                    if ($('#drawing').is(":checked")) {
                        answerfield += "<br><br><label>Tegning</label><br><canvas heigth='100' style='resize:none; border:1px solid #000000;'></canvas>";
                    }

                    $('body').bsMsgBox({
                        title: "Forhåndsvisning",
                        text: "Oppgaven du har laget vil se slik ut for en elev: <hr>"
                                + "<label>Oppgavetekst:</label> <br>" + text
                                + "<br><img id='myFilePreview' src=" +"'" +src+"' " +"alt='valgt bilde'/>"
                                + "<br><br><label>Svar:</label><br>" + answerfield
                                + "",
                        icon: 'info'
                    });
                });
            };
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

        <script>
            (function ($) {
                jQuery.fn.bsMsgBox = function (options) {
                    //Extend options by default
                    options = $.extend(true, {
                        title: 'Untitled message',
                        titletag: '<h3/>',
                        text: 'Text of a message...',
                        name: 'msgbox',
                        iconset: 'glyphicons',
                        buttons: {
                            close: {
                                type: "default",
                                doclose: true,
                                text: "Lukk"
                            }
                        }
                    }, options);

                    //Create modal
                    var make = function () {
                        //Buttons
                        var buttons = (options.buttons) ? [] : null;
                        $.each(options.buttons, function (index, button) {
                            //extend by defaults
                            button = $.extend({
                                type: "default"
                            }, button);

                            //Setting class                
                            var sClass = "btn";
                            if (button.type)
                                sClass += " btn-" + button.type;

                            //Add class to button's attributes
                            if (button.attr) {
                                if (button.attr.class) {
                                    button.attr.class += " " + sClass;
                                } else {
                                    button.attr.class = sClass;
                                }
                            } else {
                                button.attr = {class: sClass};
                            }

                            //If button should close modal
                            if (button.doclose)
                                button.attr = $.extend({'data-dismiss': "modal"}, button.attr);

                            //If button have onclick
                            if (button.onclick)
                                button.attr.onclick = button.onclick;

                            //Set button
                            buttons.push($("<button/>", button.attr).html(button.text));
                        });

                        //Helper array of icons htmls
                        var icons = {
                            glyphicons: {
                                info: "<span class='glyphicon glyphicon-info-sign text-info' style='font-size: 3em;' aria-hidden='true'></span>",
                                error: "<span class='glyphicon glyphicon-remove-sign text-danger' style='font-size: 3em;' aria-hidden='true'></span>",
                                question: "<span class='glyphicon glyphicon-question-sign text-primary' style='font-size: 3em;' aria-hidden='true'></span>",
                                ok: "<span class='glyphicon glyphicon-ok-sign text-success' style='font-size: 3em;' aria-hidden='true'></span>",
                            },
                            fontawesome: {
                                info: "<i class='fa fa-info-circle fa-4x text-info'></i>",
                                error: "<i class='fa fa-times-circle fa-4x text-danger'></i>",
                                question: "<i class='fa fa-question-circle fa-4x text-primary'></i>",
                                ok: "<i class='fa fa-check-circle fa-4x text-success'></i>"
                            }
                        };

                        //Setup icon's html
                        var icon = '';
                        if (options.icon) {
                            icon = icons[options.iconset][options.icon];
                        }

                        //Main content element
                        var content =
                                $("<div/>", {
                                    class: "modal-content"
                                }).append(
                                $("<div/>", {
                                    class: "modal-header"
                                }).append(
                                $("<button/>", {
                                    type: "button",
                                    class: "close",
                                    'data-dismiss': "modal",
                                    'aria-label': "Close"
                                }).append(
                                $("<span/>", {
                                    'aria-hidden': "true"
                                })
                                ).html("&times;")
                                ).append(
                                $(options.titletag, {
                                    class: "modal-title",
                                    id: options.name + "Label"
                                }).html(options.title)
                                )
                                ).append(
                                $("<div/>", {
                                    class: "modal-body"
                                }).append(
                                $("<div/>", {
                                    class: "media"
                                }).append(
                                $("<div/>", {
                                    class: "media-left"
                                }).html(icon)
                                ).append(
                                $("<div/>", {
                                    class: "media-body"
                                }).html(options.text)
                                )
                                )
                                );

                        //Footer element
                        var footer = null;
                        if (buttons) {
                            footer = $("<div/>", {
                                class: "modal-footer"
                            });

                            $.each(buttons, function (index, button) {
                                footer.append(button);
                                content.append(footer);
                            })
                        }

                        //Modal DOM element
                        var modalDiv =
                                $('<div/>', {
                                    class: 'modal fade',
                                    id: options.name,
                                    tabindex: '-1',
                                    role: "dialog",
                                    'aria-labelledby': options.name + "Label"
                                }).append(
                                $("<div/>", {
                                    class: "modal-dialog",
                                    role: "document"
                                }).append(
                                content
                                )
                                );

                        //Insert modal to DOM
                        $(this).append(modalDiv);

                        //hide event handler
                        $("#" + options.name).on('hidden.bs.modal', function (e) {
                            $(this).remove("#" + options.name); //Remove modal from DOM
                        });

                        //Show modal
                        $("#" + options.name).modal('show');
                    };

                    return this.each(make);
                };
            })(jQuery);
        </script>
        <script type="text/javascript" src="resources/js/upload.js"/></script>
    <script lang="Javascript">
            $(document).ready(function () {
                $('input[type="file"]').ajaxfileupload({
                    'action': 'UploadFile',
                    'onComplete': function (response) {
                        $('#upload').hide();
                        $('#message').show();
                        $('#url').show();
                        var statusVal = JSON.stringify(response.status);

                        if (statusVal == "false")
                        {
                            $("#message").html("<font color='red'>" + JSON.stringify(response.message) + "</font>");
                        }
                        if (statusVal == "true")
                        {
                            $("#message").html("<font color='green'>" + JSON.stringify(response.message) + "</font>");
                            $("#url").val(JSON.stringify(response.pictureurl));

                        }
                    },
                    'onStart': function () {
                        $('#upload').show();
                        $('#message').hide();
                    }
                });
            });
    </script>
</body>
</html>