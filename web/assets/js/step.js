$(document).ready(function(){

    $('.group').hide();
    $('#bank').show();
    $('#selectMe').change(function () {
        $('.group').hide();
        $('#'+$(this).val()).show();
    });

    $("#nextbtn").click(function(){

        $("#fstpg").addClass("d-none");
        $("#secpg").removeClass("d-none");

    });
    $("#prvbtn").click(function(){
        $("#secpg").addClass("d-none");
        $("#fstpg").removeClass("d-none");
    });

    $("#nextbtn1").click(function () {

        $("#fstpg1").addClass("d-none");
        $("#secpg1").removeClass("d-none");

    });
    $("#prvbtn1").click(function () {
        $("#secpg1").addClass("d-none");
        $("#fstpg1").removeClass("d-none");
    });
});


var googleUser = {};
var startApp = function () {
    gapi.load('auth2', function () {
        // Retrieve the singleton for the GoogleAuth library and set up the client.
        auth2 = gapi.auth2.init({
            client_id: 'YOUR_CLIENT_ID.apps.googleusercontent.com',
            cookiepolicy: 'single_host_origin',
            // Request scopes in addition to 'profile' and 'email'
            //scope: 'additional_scope'
        });
        attachSignin(document.getElementById('customBtn'));
    });
};

function attachSignin(element) {
    console.log(element.id);
    auth2.attachClickHandler(element, {},
        function (googleUser) {
            document.getElementById('name').innerText = "Signed in: " +
                googleUser.getBasicProfile().getName();
        }, function (error) {
            alert(JSON.stringify(error, undefined, 2));
        });
}