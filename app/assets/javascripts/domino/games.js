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
    var $rBox = $( "#rotateBox" );

    $rBox.droppable({
        drop: function( event, ui ) {
            //
            $( this )
                .find( "p" )
                .html( "Dropped!" );
            rotateBone( ui.draggable );
        }
    });

    function rotateBone( $bone ) {
      $bone
        .css({ "transform": "rotate(90deg)", "-webkit-transform": "rotate(90deg)", "-moz-transform": "rotate(90deg)" })
        .find( "div" )
        .fadeIn();
    }
});