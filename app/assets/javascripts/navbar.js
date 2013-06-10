$(document).ready(function () {
    var navbarbuttonlist = $('#navbarbuttonlist li');

    navbarbuttonlist.click(function (e) {
        removeActive();
        var $this = $(this);
        $this.toggleClass('active');
        e.preventDefault();
    });

    function removeActive() {
        navbarbuttonlist.removeClass('active');
    };
});
