/* 
 * Dette scriptet styrer info-boksene i createfunctiontask
 */

// Viser informasjon om GeoGebra
var showgeo = function () {
    jQuery(function ($) {
        $('body').bsMsgBox({
            title: "Geogebra",
            text: "Velg dette alternativet dersom du ønsker at eleven skal svare med Geogebra",
            icon: 'info'
        });
    });
};

// Viser hvordan man oppretter flervalgsoppgaver
var showflervalg = function () {
    jQuery(function ($) {
        $('body').bsMsgBox({
            title: "Flervalgstest",
            text: "Velg dette alternativet dersom du ønsker at eleven skal svare med flervalgstest"
                    + "<hr> Skriv inn svaralternativene i disse feltene:<br>"
                    + "<img src='resources/images/alternativ.png' alt='alternativ'>"
                    + "<hr> Trykk pluss eller minus for å legge til eller fjerne et alternativ:<br>"
                    + "<img src='resources/images/plussminus.png' alt='plussminus'>"
                    + "<hr> Velg svaralternativet som er det korrekte i denne dropdownlisten:<br>"
                    + "<img src='resources/images/velgalternativ.png' alt='velgalternativ'>",
            icon: 'info'
        });
    });
};

// Viser hva man får ved å velge alternativet tekstsvar
var showtekstsvar = function () {
    jQuery(function ($) {
        $('body').bsMsgBox({
            title: "Tekstsvar",
            text: "Velg dette alternativet dersom du ønsker at eleven skal svare med tekstsvar",
            icon: 'info'
        });
    });
};


