// Listen inneholder variabler benyttet i konfigurasjonen av GeoGebra
var parameters = {"prerelease": false, "width": 800, "height": 600, "borderColor": null, "showToolBar": true, "showMenuBar": false, "showAlgebraInput": false,
    "showResetIcon": false, "enableLabelDrags": false, "enableShiftDragZoom": true, "enableRightClick": false, "capturingThreshold": null, "showToolBarHelp": false,
    "errorDialogsActive": true, "useBrowserForJS": true, "enableCAS": true};
// Applet som inneholder GeoGebra-vinduet som lastes inn i functiontask.jsp
var applet = new GGBApplet('5.0', parameters);

applet.setJavaCodebase('GeoGebra/Java/5.0');
// Metoden benyttes til å legge GeoGebra med forhåndsvalgt konfigurasjon inn i en applet
window.onload = function () {
    applet.inject('applet_container', 'preferHTML5');
};
// registrer add, remove, rename og update listeners for GeoGebra
function ggbOnInit() {   
    var d = new Date();
    var n = d.getTime();
    document.getElementById('hidden4').value = n;
    var applet = document.ggbApplet;
    applet.registerAddListener("addListener");
    applet.registerRemoveListener("removeListener");
    applet.registerRenameListener("renameListener");
    applet.registerClearListener("clearListener");
    applet.registerUpdateListener("updateListener");
}
// Metoden definerer en lytter som registrer hver gang et element blir lagt til i GeoGebra-vinduet
function addListener(objName) {
    var d = new Date();
    var n = document.getElementById('hidden4').value;
    var k = (d.getTime() - n) / 1000;
    var strVal = document.ggbApplet.getValueString(objName);
    document.getElementById('geooutput').value += "Add: " + strVal + " | " + k + "\n";
}
// Metoden definerer en lytter som registrer hver gang et element blir slettet fra GeoGebra-vinduet
function removeListener(objName) {
    var d = new Date();
    var n = document.getElementById('hidden4').value;
    var k = (d.getTime() - n) / 1000;
    document.getElementById('geooutput').value += "Remove: " + objName + " | " + k + "\n";
}
// Metoden definerer en lytter som registrer hver gang et element blir oppdatert i GeoGebra-vinduet
function updateListener(objName) {
    var d = new Date();
    var n = document.getElementById('hidden4').value;
    var k = (d.getTime() - n) / 1000;
    var strVal = document.ggbApplet.getValueString(objName);

    document.getElementById('updateoutput').value += "Update: " + strVal + " | " + k + "\n";
}

// Metoden brukes til å sjekke når GeoGebra-vinduet er ferdig lastet, og laster inn GeoGebra-oppgaven
var readyCheck = setInterval(function () {
    if (document.getElementById('functionstring')) {
        var strInput = document.getElementById('functionstring').value;
        ggbApplet.setBase64(strInput);
        clearInterval(readyCheck);
    }
}, 1);
// Metoden styrer hvilke av lytter-registreringene som lagres i databasen
function updateUpdate() {
    var field = document.getElementById('updateoutput').value;
    var updatefield = document.getElementById('geooutput');
    var lines = field.split('\n');
    var linje = [];

    for (var i = 0; i < lines.length; i++) {
        var str = lines[i];
        var nystr = str.substring(str.indexOf("|") + 1);
        linje[i] = nystr;
    }

    for (var k = 0; k < linje.length; k++) {
        var h = parseFloat(linje[k]);
        var s = parseFloat(linje[k + 1]);
        if (h + 0.3 < s) {
            updatefield.value += lines[k] + "\n";
        }
        if (k == (linje.length - 1)) {
            updatefield.value += lines[k - 1];
        }
    }
}
// Metoden henter listen laget i updateUpdate() og setter de til en felles string som lagres i databasen
function setGeoText() {
    var valuefield = document.getElementById('geooutput').value;
    var lines = valuefield.split('\n');
    var textfield = document.getElementById('updatetext');

    for (var i = 0; i < lines.length; i++) {
        if (i == (lines.length - 1)) {
            textfield.value += lines[i];
        } else {
            textfield.value += lines[i] + "|||";
        }
    }
}
// Metoden brukes til å hente GeoGebra appen som en base64 string og legger den til i en skjult tekstboks i functiontask.jsp
function putBase64() {
    var geoString = ggbApplet.getBase64();
    document.getElementById('hidden3').value = geoString;
}


