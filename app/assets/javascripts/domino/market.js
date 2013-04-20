/**
 * Created with JetBrains RubyMine.
 * User: ostap
 * Date: 4/19/13
 * Time: 11:27 AM
 * To change this template use File | Settings | File Templates.
 */


$(function () {



    $('#market').click(function(evt) {
        evt.preventDefault();
        passBoneFromMarket(this);
    });


    function passBoneFromMarket($bone) {
        $(function () {
            var id = getURLid();
            $.ajax({
                type: "GET",
                url: "take_from_market/" + id,
                success: function () {
                    $("#player_1").append('sdfdsfdsfdsfdsfsd');
                }
            });
        });
        refreshPlayerBones();
    }

    function refreshPlayerBones () {
        var data = "foobar";
        $("#player_2").hide().html(data).fadeIn('fast');
    }

    function getURLid() {
        var full_url = document.URL; // Get current url
        var url_array = full_url.split('/'); // Split the string into an array with / as separator
        return url_array[url_array.length-1];  // Get the last part of the array (-1)
    }

});