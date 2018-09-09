// var click= $('.click');
// var span= $(click[0]).find('span');
// $(click[0]).click(function() {
// 	if ($(span).hasClass("fa-heart")) {
// 			$(click[0]).removeClass('active')
// 		setTimeout(function() {
// 			$(click[0]).removeClass('active-2')
// 		}, 30)
// 			$(click[0]).removeClass('active-3')
// 		setTimeout(function() {
// 			$(span).removeClass('fa-heart')
// 			$(span).addClass('fa-heart-o')
// 		}, 15)
// 	} else {
// 		$(click[0]).addClass('active')
// 		$(click[0]).addClass('active-2')
// 		setTimeout(function() {
// 			$(span).addClass('fa-heart')
// 			$(span).removeClass('fa-heart-o')
// 		}, 150)
// 		setTimeout(function() {
// 			$(click[0]).addClass('active-3')
// 		}, 150)
// 		$('.info').addClass('info-tog')
// 		setTimeout(function(){
// 			$('.info').removeClass('info-tog')
// 		},1000)
// 	}
// })

function heartcng(ide){
     var click= $('.click');
var span= $(click[ide]).find('span');

	if ($(span).hasClass("fa-heart")) {
			$(click[ide]).removeClass('active')
		setTimeout(function() {
			$(click[ide]).removeClass('active-2')
		}, 30)
			$(click[ide]).removeClass('active-3')
		setTimeout(function() {
			$(span).removeClass('fa-heart')
			$(span).addClass('fa-heart-o')
		}, 15)
	} else {
		$(click[ide]).addClass('active')
		$(click[ide]).addClass('active-2')
		setTimeout(function() {
			$(span).addClass('fa-heart')
			$(span).removeClass('fa-heart-o')
		}, 150)
		setTimeout(function() {
			$(click[ide]).addClass('active-3')
		}, 150)
		$('.info').addClass('info-tog')
		setTimeout(function(){
			$('.info').removeClass('info-tog')
		},1000)
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


var imagesPreview = function (input, placeToInsertImagePreview) {

    if (input.files) {

        var filesAmount = input.files.length;


        for (i = 0; i < 3; i++) {

            // if(!/\.(jpe?g|png|gif)$/i.test(input.files[i]))
            // {
            //     return alert(" is not an image");
            // }

            var reader = new FileReader();

            reader.onload = function (event) {
                $($.parseHTML('<img>')).attr('src', event.target.result).appendTo(placeToInsertImagePreview);
            }

            reader.readAsDataURL(input.files[i]);
        }
    }

};

$('#gallery-photo-add').on('change', function () {

    $('.gallery').empty();
    imagesPreview(this, 'div.gallery');
});


    
