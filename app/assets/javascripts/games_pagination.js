/**
 * Created with JetBrains RubyMine.
 * User: ostap
 * Date: 4/22/13
 * Time: 10:27 AM
 * To change this template use File | Settings | File Templates.
 */

$(function () {
    $('#current_games').on('click','a', function () {
        $('.pagination').html('Page is loading...');
        $.get(this.href, null, null, 'script');
        return false;
    });

    $('#finished_games').on('click','a', function () {
        $('.pagination').html('Page is loading...');
        $.get(this.href, null, null, 'script');
        return false;
    });

    $('#friends').on('click','a', function () {
        $('.pagination').html('Page is loading...');
        $.get(this.href, null, null, 'script');
        return false;
    });
});