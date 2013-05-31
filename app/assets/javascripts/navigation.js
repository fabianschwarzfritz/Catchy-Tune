//= require jquery.pjax

$(function () {
    $(document).pjax('a[data-pjax!="false"]:not([data-no-pjax]', '#pjax-container', {timeout:5000});
    $(document).on('submit', 'form[data-pjax]', function (event) {
        $.pjax.submit(event, '#pjax-container');
    });
});
