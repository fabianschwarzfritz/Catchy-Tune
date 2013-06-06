//= require application

$(document).on('mouseenter', '.track-search-result', function () {
    var popup = $(this).find('.popup');
    popup.show();
    $(this).on('mouseleave', function () {
        popup.hide(300);
    });
});
