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
                    + "<br><img id='myFilePreview' src=" + "'" + src + "' " + "alt=''/>"
                    + "<br><br><label>Svaregil:</label><br>" + answerfield
                    + "",
            icon: 'info'
        });
    });
};


