$(document).ready(function(){
    
    $("#nextbtn").click(function(){

        $("#fstpg").addClass("d-none");
        $("#secpg").removeClass("d-none");

    });
    $("#prvbtn").click(function(){
        $("#secpg").addClass("d-none");
        $("#fstpg").removeClass("d-none");
    });


});

