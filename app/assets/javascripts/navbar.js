$(document).ready(function () {
    $('#navbarbuttonlist li').click(function (e) {
        removeActive();
        var $this = $(this);
        $this.toggleClass('active');
        e.preventDefault();
    });

    function removeActive() {
        $('#navbarbuttonlist li').removeClass('active');
    };
});