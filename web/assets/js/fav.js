function heartcng(elm, pid) {
var span= $(elm).find('span');

	if ($(span).hasClass("fa-heart")) {
			$(elm).removeClass('active');
			$(elm).removeClass('active-3');
        $.post("favourite", {
            pid: pid,
            action: "delete"
        });
		setTimeout(function() {
			$(span).removeClass('fa-heart');
			$(span).addClass('fa-heart-o')
		}, 15)
	} else {
		$(elm).addClass('active');
        $.post("favourite", {
            pid: pid,
            action: "add"
        });
		setTimeout(function() {
			$(span).addClass('fa-heart');
			$(span).removeClass('fa-heart-o')
		}, 150)
		
		
	}
}

function deleteProduct(elm, pid) {
    var span = $(elm).find('span');

    if ($(span).hasClass("fa-heart")) {
        $(elm).removeClass('active');
        $(elm).removeClass('active-3');
        $.post("favourite", {
            pid: pid,
            action: "delete"
        });
        setTimeout(function () {
            $(span).removeClass('fa-heart');
            $(span).addClass('fa-heart-o')
        }, 15)
    } else {
        $(elm).addClass('active');
        $.post("favourite", {
            pid: pid,
            action: "add"
        });
        setTimeout(function () {
            $(span).addClass('fa-heart');
            $(span).removeClass('fa-heart-o')
        }, 150)


    }
}

function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#blah')
                    .attr('src', e.target.result)
                    .width(50)
                    .height(50);
            };

            reader.readAsDataURL(input.files[0]);
        }
    }


var imagesPreview = function(input, placeToInsertImagePreview) {

        if (input.files) {
            
            var filesAmount = input.files.length;
            

            for (i = 0; i < 3; i++) {
                
                    // if(!/\.(jpe?g|png|gif)$/i.test(input.files[i]))
                    // {
                    //     return alert(" is not an image");
                    // }
                    
                var reader = new FileReader();

                reader.onload = function(event) {
                    $($.parseHTML('<img>')).attr('src', event.target.result).appendTo(placeToInsertImagePreview);
                }

                reader.readAsDataURL(input.files[i]);
            }
        }

    };

    $('#gallery-photo-add').on('change', function() {
        if($("#gallery-photo-add")[0].files[0].size>6427100)
            {
                alert($("#gallery-photo-add")[0].files[0].size);
            }
        if($("#gallery-photo-add")[0].files.length > 3) {
            $('#gallery-photo-add').val('');
            $('.gallery').empty();
                   alert("You can select only 3 images");
            
            
         } else {
             $('.gallery').empty();
             imagesPreview(this, 'div.gallery');
               $("#imageUploadForm").submit();
         }
        
        
    });

$('.delet').click(function(){
    return confirm('Are you sure you want to delete this comment?');
});
$('#deact').click(function(){
    return confirm('Are you sure you want to deactivate your account?');
});

    





    
