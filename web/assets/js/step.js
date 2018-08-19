$(document).ready(function(){
    
    $("#nextbtn").click(function(){
        $("#fstpg").addClass("d-none");
        $("#secpg").removeClass("d-none");

    });
    $("#nextbtn1").click(function () {
        $("#fstpg1").addClass("d-none");
        $("#secpg1").removeClass("d-none");

    });
    $("#prvbtn").click(function(){
        $("#secpg").addClass("d-none");
        $("#fstpg").removeClass("d-none");
    });
});