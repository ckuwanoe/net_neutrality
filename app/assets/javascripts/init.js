$(document).ready(function() {

    $('textarea').autosize();

    //header links
    $('header nav a').click(function() {
        $(this).parent().siblings().find('.active').removeClass('active');
        $(this).addClass('active');
    });

    //start slider depending of resolution
    var width_page = $(document).width();



    //scripts for resolutions smaller than 768px
    if (width_page < 768) {
        $('header nav ul').css('width', width_page);

        //make visible list of #filters on mobile resolution
        $('.filter_wrap').mouseover(function() {
            $('#filters').show();
            $('#filters li a').click(function() {
                $(this).parent().parent().hide();
                var text = $(this).html();
                $('.filter_wrap span').html(text);
                //add <b> element to .filter_wrap
                $('.filter_wrap > span').append('<b></b>');
            });
        });
        $('.filter_wrap').mouseout(function() {
            $('#filters').hide();
        });

        $('header nav').mouseover(function() {
            $(this).children().show();
            $('header nav li a').click(function() {
                $(this).parent().parent().hide();
            });

        });
        $('header nav').mouseout(function() {
            $(this).children().hide();
        });

        // $('header nav').mouseover(function(){
        //     $(this).children().show();
        //     $(this).children().css({
        //       'visibility': 'visible',
        //       'opacity': '1'
        //     });
        // });
        $('.slide .arrow_up').hide();

        $('.slider2 .slide a').click(function() {

            // $('.slider2_popups .active-popup').removeClass('active-popup');      
            $(this).removeClass('slvzr-hover');
            var current = $(this).attr('class');
            var current_small = $(this).parent();

            $('.slider2_popups .popup-item.' + current).appendTo(current_small);

            $('.popup-item.' + current).addClass('active-popup').parent().siblings().children().removeClass('active-popup');

            // alert(current);
            // return false;
        });

        //height of subheader
        var sub_height = $(window).height() - 2 * ($('header').height());
        $('.subheader').css('height', sub_height);

    }

    //scripts for resolutions larger than, or equal to 768px
    if (width_page >= 768) {
        $('.slider2 .slide a').click(function() {

            $(this).removeClass('slvzr-hover');
            var current = $(this).attr('class');
            // alert(current);
            var boxclass = "active-popup";
            var arrowclass = "active-arrow";
            $('.slide .arrow_up.' + current).addClass(arrowclass).parent().siblings().children().removeClass(arrowclass);

            $('.slider2_popups .popup-item.' + current).addClass(boxclass).siblings().removeClass(boxclass);
            return false;
        });

        //height of subheader
        var sub_height = $(window).height() - 3 * ($('header').height());
        $('.subheader').css('height', sub_height);

    }

    if (width_page > 540 && width_page <= 649) {
        $('.slider1').bxSlider({
            slideWidth: 200,
            minSlides: 2,
            maxSlides: 2,
            moveSlides: 1,
            slideMargin: 0
        });
    }

    if (width_page >= 650 && width_page <= 959) {
        $('.slider1').bxSlider({
            slideWidth: 190,
            minSlides: 3,
            maxSlides: 3,
            moveSlides: 1,
            slideMargin: 0
        });
        $('.slider2').bxSlider({
            slideWidth: 226,
            minSlides: 1,
            maxSlides: 2,
            moveSlides: 1,
            slideMargin: 60,
            infiniteLoop: false
        });
    }

    if (width_page >= 960) {
        $('.slider1').bxSlider({
            slideWidth: 190,
            minSlides: 4,
            maxSlides: 4,
            moveSlides: 1,
            slideMargin: 0
        });
        $('.slider2').bxSlider({
            slideWidth: 226,
            minSlides: 3,
            maxSlides: 3,
            slideMargin: 60,
            moveSlides: 1,
            infiniteLoop: false
        });
    }


    var top_ofset = $('header').height() - 1;


    $('header li a, .logo, .down, .subheader .btn, footer .container > a').click(function() {
        $('html, body').animate({
            scrollTop: $($(this).attr('href')).offset().top - top_ofset
        }, 10);
    });



    $('.popup-item .close').click(function() {
        $('.active-popup').removeClass('active-popup');
        $('.arrow_up').removeClass('active-arrow');
    });

    //adding class to list item (make active)
    if (width_page >= 768) {
        $('#filters li a').click(function() {
            $(this).parent().siblings().removeClass('active');
            $(this).parent().addClass('active');
        });

        var popup_width = $('#team .bx-wrapper').width();
        var popup_left_margin = -($('#team .bx-wrapper').width() / 2);
        $('.popup-item')
            .css({
                'width': popup_width,
                'margin-left': popup_left_margin
            });
    }


    //calculate width of lightbox
    var width_of_lightbox = $('.container').width();
    $('.lb-outerContainer, .lb-dataContainer').css('width', width_of_lightbox);



    //scroll to the top icon
    $(window).scroll(function() {
        if ($(this).scrollTop() > 100) {
            $('#to_the_top').fadeIn();
        } else {
            $('#to_the_top').fadeOut();
        }
    });
    $('#to_the_top').click(function() {
        $("html, body").animate({
            scrollTop: 0
        }, 600);
        $(this).fadeOut(500);
        return false;
    });

    //validate contact form
    $("form.contact-form").validate({
        rules: {
            "commenter[name]": {
                required: true,
                minlength: 2
            },
            "commenter[message]": {
                required: true,
                minlength: 2
            },
            "commenter[email]": {
                required: true,
                email: true
            },
            "commenter[address_line_1]": {
                required: true
            },
            "commenter[zip]": {
                required: true
            }
        },
        messages: {
            "commenter[name]": {
                required: "This field is required",
                minlength: jQuery.format("At least {0} characters required")
            },
            "commenter[address_line_1]": {
                required: "This field is required",
                minlength: jQuery.format("At least {0} characters required")
            },
            "commenter[zip]": {
                required: "This field is required",
                minlength: jQuery.format("At least {0} characters required")
            },
            "commenter[message]": {
                required: "This field is required",
                minlength: jQuery.format("At least {0} characters required")
            },
            "commenter[email]": {
                required: "This field is required",
                email: "Wrong e-mail address"
            }
        },
        errorClass: "error"
    });

});






//PLACEHOLDER
$('[placeholder]').focus(function() {
    var input = $(this);
    if (input.val() == input.attr('placeholder')) {
        input.val('');
        input.removeClass('placeholder');
    }
}).blur(function() {
    var input = $(this);
    if (input.val() == '' || input.val() == input.attr('placeholder')) {
        input.addClass('placeholder');
        input.val(input.attr('placeholder'));
    }
}).blur().parents('form').submit(function() {
    $(this).find('[placeholder]').each(function() {
        var input = $(this);
        if (input.val() == input.attr('placeholder')) {
            input.val('');
        }
    })
});