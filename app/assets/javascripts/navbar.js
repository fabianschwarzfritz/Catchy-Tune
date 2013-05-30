/**
 * Created with JetBrains RubyMine.
 * User: D056995
 * Date: 30.05.13
 * Time: 18:57
 * To change this template use File | Settings | File Templates.
 */
//= require jquery.pjax

$(function () {
    $(document).pjax('a[data-pjax]', '#pjax-container');
    $(document).on('submit', 'form[data-pjax]', function (event) {
        $.pjax.submit(event, '#pjax-container');
    });
});