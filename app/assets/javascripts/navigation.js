//= require jquery.pjax

$(function () {
    $(document).pjax('a[data-pjax]', '#pjax-container');
    $(document).on('submit', 'form[data-pjax]', function (event) {
        $.pjax.submit(event, '#pjax-container');
    });
});
