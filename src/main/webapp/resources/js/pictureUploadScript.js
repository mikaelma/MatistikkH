/* Scriptet brukes i creatfunctiontask.jsp til å utføre filopplastninger til server. Dette scriptet knytter responsen (url til bildet) til html element i formen.
*  Funksjonen ajaxfileupload er opprettet i upload.js og står for ajaxkall mot UploadFile.java som står for selve filopplastningen
*  
*  
 **/
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
