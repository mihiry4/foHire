var validate1 = true, validate2 = true;
$("#change_pass").click(function () {
    if (validate1 && validate2) {
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
});