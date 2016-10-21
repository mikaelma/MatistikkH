/*
 * Javascript for diverse funksjonalitet i createfunctiontask.jsp
 */
var counter = 3;

// Metoden legger til antall svaralternativer for flervalgsoppgaver i createfunctiontask
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

function setText() {
    document.getElementById("hidden2").value = document.getElementById("alternativ1").value + "|||" + document.getElementById("alternativ2").value;
    for (i = 3; i < counter; i++) {
        document.getElementById("hidden2").value += '|||' + document.getElementById('alternativ' + i).value;
    }

    document.getElementById("hidden1").value = document.getElementById("dropdown").value;
}

// Metoden gjør det mulig å vise en preview av bildet man laster opp i createfunctiontask
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

function putBase64() {
    var geostring = ggbApplet.getBase64();
    document.getElementById('hidden4').value = geostring;
}