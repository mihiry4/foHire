$(document).ready(function(){
    $("#change_pass").click(function () {
        const new_p=$("#new").val();
        var new_p_l=$("#new").val().length;
        console.log(new_p_l);
        const conf=$("#conf").val();
        if( new_p_l > 7 && new_p===conf) {
            $.post("changePass", {
                old_pass: $("#old").val(),
                new_pass: $("#new").val(),
                conf_pass: $("#conf").val()
            }, function () {
                $("#stat").text("Password changed successfully").css("background-color", "green");
            }).fail(function (xhr, status, error) {
                $("#stat").text(error).css("background-color", "red");
            })
        }
        else{
            $("#stat").text("Please follow conditions!").css("background-color", "red");
            return false;
        }
    });
});



