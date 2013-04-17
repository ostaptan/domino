$(function() {
    $( "#draggable_0-0" ).draggable({ cursor: "move", revert: "invalid", scroll: false });
    $( "#draggable_0-1" ).draggable({ cursor: "move", revert: "invalid", scroll: false });
    $( "#draggable_0-2" ).draggable({ cursor: "move", revert: "invalid", scroll: false });
    $( "#draggable_0-3" ).draggable({ cursor: "move", revert: "invalid", scroll: false });
    $( "#draggable_0-4" ).draggable({ cursor: "move", revert: "invalid", scroll: false });
    $( "#draggable_0-5" ).draggable({ cursor: "move", revert: "invalid", scroll: false });
    $( "#draggable_0-6" ).draggable({ cursor: "move", revert: "invalid", scroll: false });
    $( "#draggable_1-1" ).draggable({ cursor: "move", revert: "invalid", scroll: false });
    $( "#draggable_1-2" ).draggable({ cursor: "move", revert: "invalid", scroll: false });
    $( "#draggable_1-3" ).draggable({ cursor: "move", revert: "invalid", scroll: false });
    $( "#draggable_1-4" ).draggable({ cursor: "move", revert: "invalid", scroll: false });
    $( "#draggable_1-5" ).draggable({ cursor: "move", revert: "invalid", scroll: false });
    $( "#draggable_1-6" ).draggable({ cursor: "move", revert: "invalid", scroll: false });
    $( "#draggable_2-2" ).draggable({ cursor: "move", revert: "invalid", scroll: false });
    $( "#draggable_2-3" ).draggable({ cursor: "move", revert: "invalid", scroll: false });
    $( "#draggable_2-4" ).draggable({ cursor: "move", revert: "invalid", scroll: false });
    $( "#draggable_2-5" ).draggable({ cursor: "move", revert: "invalid", scroll: false });
    $( "#draggable_2-6" ).draggable({ cursor: "move", revert: "invalid", scroll: false });
    $( "#draggable_3-3" ).draggable({ cursor: "move", revert: "invalid", scroll: false });
    $( "#draggable_3-4" ).draggable({ cursor: "move", revert: "invalid", scroll: false });
    $( "#draggable_3-5" ).draggable({ cursor: "move", revert: "invalid", scroll: false });
    $( "#draggable_3-6" ).draggable({ cursor: "move", revert: "invalid", scroll: false });
    $( "#draggable_4-4" ).draggable({ cursor: "move", revert: "invalid", scroll: false });
    $( "#draggable_4-5" ).draggable({ cursor: "move", revert: "invalid", scroll: false });
    $( "#draggable_4-6" ).draggable({ cursor: "move", revert: "invalid", scroll: false });
    $( "#draggable_5-5" ).draggable({ cursor: "move", revert: "invalid", scroll: false });
    $( "#draggable_5-6" ).draggable({ cursor: "move", revert: "invalid", scroll: false });
    $( "#draggable_6-6" ).draggable({ cursor: "move", revert: "invalid", scroll: false });
    var $rBox = $( "#rotateBox"),
        $firstPlace = $("#firstPlace"),
        $rightPlace = $("#right"),
        $leftPlace = $("#left");

    $firstPlace.droppable ({
        drop: function( event, ui ) {
            $(function()
            {
                var done;

                if( done ) return;
                done = true;


                createHPlacesFor(ui.draggable)
            });
        }
    });

    $rightPlace.droppable ({
        drop: function( event, ui ) {
            $( this )
                .find( "div" )
                .html( "Moved!" );
            createHPlacesFor(ui.draggable)
        }
    });

    $leftPlace.droppable ({
        drop: function( event, ui ) {
            $( this )
                .find( "div" )
                .html( "Moved!" );
            createHPlacesFor(ui.draggable)
        }
    });

    $rBox.droppable({
        drop: function( event, ui ) {
            $( this )
                .find( "p" )
                .html( "Dropped!" );
            rotateBone( ui.draggable );
        }
    });

    function createHPlacesFor($previousBone) {
        var offsets = $previousBone.offset();
        var top = offsets.top;
        var left = offsets.left;
        createHPlace(top, left, 'left');
        createHPlace(top, left, 'right');
    }

    function createHPlace($top, $left, $type) {
        var divTag = document.createElement("div");
        divTag.id = $type;
        if ($type == 'right') {
            divTag.style.top = $top - 20;
            divTag.style.left = $left + 41;
        } else if ($type == 'left') {
            divTag.style.top = $top - 20;
            divTag.style.left = $left - 166;
        }
        divTag.style.margin = "0px auto";
        divTag.className = "dynamicHDiv";
        document.getElementById('battle-field').appendChild(divTag);
    }

    function createVPlaceFor($previousBone) {
        var offsets = $previousBone.offset();
        var top = offsets.top;
        var left = offsets.left;

    }

    function rotateBone( $bone ) {
      $bone
        .css({ "transform": "rotate(90deg)", "-webkit-transform": "rotate(90deg)", "-moz-transform": "rotate(90deg)" })
        .find( "div" )
        .fadeIn();
    }
});