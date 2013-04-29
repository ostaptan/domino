/**
 * Created with JetBrains RubyMine.
 * User: maxputin
 * Date: 28.04.13
 * Time: 11:30
 * To change this template use File | Settings | File Templates.
 */

    (function() {
        var page = 1,
            loading = false;

        function nearBottomOfPage() {
            return $(window).scrollTop() > $(document).height() - $(window).height() - 50;
        }

        $(window).scroll(function(){
            if (loading) {
                return;
            }

            if(nearBottomOfPage()) {
                loading=true;
                page++;
                $.ajax({
                    url: 'dashboard?page=' + page,
                    type: 'get',
                    dataType: 'script',
                    success: function() {
                        $(window).sausage('draw');
                        loading=false;
                    }
                });
            }
        });


    }());

