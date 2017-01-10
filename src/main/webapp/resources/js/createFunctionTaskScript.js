/*
 * Javascript for diverse funksjonalitet i createfunctiontask.jsp
 */

// Metoden legger til antall svaralternativer for flervalgsoppgaver i createfunctiontask
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
// Metoden fjerner antall svaralternativer for flervalgsoppgaver i createfunctiontask
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

// Metoden henter alle svaralternativer, og setter de sammen til en string som lagres i databasen
function setText() {
    document.getElementById("hidden2").value = document.getElementById("alternativ1").value + "|||" + document.getElementById("alternativ2").value;
    for (i = 3; i < counter; i++) {
        document.getElementById("hidden2").value += '|||' + document.getElementById('alternativ' + i).value;
    }

    document.getElementById("hidden1").value = document.getElementById("dropdown").value;
}


// Listen inneholder variabler benyttet i konfigurasjonen av GeoGebra
var parameters = {
    "id": "ggbApplet",
    "width": 800,
    "height": 600,
    "showToolBar": true,
    "borderColor": null,
    "showMenuBar": true,
    "allowStyleBar": true,
    "showAlgebraInput": true,
    "enableLabelDrags": false,
    "enableShiftDragZoom": true,
    "capturingThreshold": null,
    "showToolBarHelp": false,
    "errorDialogsActive": true,
    "showTutorialLink": false,
    "showLogging": false,
    "useBrowserForJS": false
};

// Applet som inneholder GeoGebra-vinduet som lastes inn i createfunctiontask.jsp
var applet = new GGBApplet(parameters, '5.0', 'applet_container');
//  when used with Math Apps Bundle, uncomment this:
//  applet.setHTML5Codebase('GeoGebra/HTML5/5.0/web3d/');

// Metoden benyttes til å legge GeoGebra med forhåndsvalgt konfigurasjon inn i en applet
window.onload = function () {
    applet.inject('applet_container', 'preferhtml5');
};



// Metoden brukes til å hente GeoGebra appen som en base64 string og legger den til i en skjult tekstboks i createfunctiontask.jsp
var putBase64 = function () {
    jQuery(function ($) {
        if ($('#geocheck').is(":checked")) {
            var geostring = ggbApplet.getBase64();
            document.getElementById('hidden4').value = geostring;
        }
    });
};

// Metoden setter farger for panelet ved valg av svarform
function radioClick(myRadio) {
    var valg = myRadio.value;
    if (valg == 1) {
        document.getElementById('tekstRadio').className = "panel panel-success";
        document.getElementById('flervalgRadio').className = "panel panel-default";
        document.getElementById('geoRadio').className = "panel panel-default";
    } else if (valg == 2) {
        document.getElementById('tekstRadio').className = "panel panel-default";
        document.getElementById('flervalgRadio').className = "panel panel-success";
        document.getElementById('geoRadio').className = "panel panel-default";
    } else {
        document.getElementById('tekstRadio').className = "panel panel-default";
        document.getElementById('flervalgRadio').className = "panel panel-default";
        document.getElementById('geoRadio').className = "panel panel-success";
    }
}

// Metoden setter fargen til "Legg til GeoGebra" panelet dersom det er valgt
function geogebraClick() {
    var panel = document.getElementById('geogebrapanel');
    var checkbox = document.getElementById('geocheck');
    if (checkbox.checked) {
        panel.className = "panel panel-success";
    } else {
        panel.className = "panel panel-default";
    }
}

// Metoden henter innholdet i teksteditoren for oppgavetekst og legger den til et skjult textarea. 
// Den tar også et screenshot av GeoGebra-vinduet og legger en base64 string i et skjult tekstfelt.
// Brukes i forbindelse med forhåndsvisningen
function setTekst() {
    var text = CKEDITOR.instances.questionText.getData();
    var felt = document.getElementById('hidden7');
    felt.value = text;
    var geofelt = document.getElementById('hidden8');

    var geocheck = document.getElementById('geocheck');
    if (geocheck.checked) {
        var geobilde = ggbApplet.getPNGBase64(0.8, true);
        geofelt.value = geobilde;
    } else {
        geofelt.value = "";
    }
}

// Metoden oppretter en modal med forhåndsvisning av oppgaven.
var showforhand = function () {
    jQuery(function ($) {
        var text = $('input[type=hidden]#hidden7').val();
        var valg = $("input:radio[name ='answer_type']:checked").val();
        var geobildet = $('input[type=hidden]#hidden8').val();
        var answerfield = "";

        if (geobildet == "") {
            answerfield = "";
        } else {
            answerfield = "<div class='panel panel-warning'><div class='panel-heading'><h3 class='panel-title'>Geogebra</h3></div><div class='panel-body'><img id='geobilde' src='data:image/png;base64, " + geobildet + "' " + "alt=''/></div></div>";
        }
        if (valg == 1) {
            answerfield += "<div class='panel panel-warning'><div class='panel-heading'><h3 class='panel-title'>Tekstsvar</h3></div><div class='panel-body'><textarea style='min-width: 100%; resize:none'></textarea></div></div>";
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
            answerfield += "<label>Velg riktig alternativ: </label><br><input type='radio' name='options'>" + alternativ1 + "<br><input type='radio' name='options'>" + alternativ2;
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
            answerfield += "<div class='panel panel-warning'><div class='panel-heading'><h3 class='panel-title'>Forklaring</h3></div><div class='panel-body'><textarea style='min-width: 100%; resize:none'></textarea></div></div>";
        }

        $('body').bsMsgBox({
            title: "Forhåndsvisning",
            text: "Oppgaven du har laget vil se slik ut for en elev: <hr>"
                    + "<div class='panel panel-info'><div class='panel-heading'><h3 class='panel-title'>Oppgave</h3></div><div class='panel-body'>" + text + "</div></div>"
                    + "<div class='panel panel-success'><div class='panel-heading'><h3 class='panel-title'>Svar</h3></div><div class='panel-body'>" + answerfield + "</div></div>"
                    + "",
            icon: 'info'
        });
    });
};
     