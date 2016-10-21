/*
 * Javascript som definerer hvordan GeoGebra-applet skal utformes, og gjør det mulig for å injecte det til navngitt <div> på siden.
 */


var parameters = {"prerelease": false, "showToolBar": true, "borderColor": null, "showMenuBar": true, "showAlgebraInput": false,
    "showResetIcon": true, "enableLabelDrags": false, "enableShiftDragZoom": true, "enableRightClick": false, "capturingThreshold": null, "showToolBarHelp": false,
    "errorDialogsActive": true, "useBrowserForJS": false};
var applet = new GGBApplet('5.0', parameters);
applet.setJavaCodebase('GeoGebra/Java/5.0');
window.onload = function () {
    applet.inject('applet_container', 'preferHTML5');
}