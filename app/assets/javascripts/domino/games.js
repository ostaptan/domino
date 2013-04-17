$(function () {
    $("#0-0").draggable({ cursor: "move", revert: "invalid", scroll: false });
    $("#0-1").draggable({ cursor: "move", revert: "invalid", scroll: false });
    $("#0-2").draggable({ cursor: "move", revert: "invalid", scroll: false });
    $("#0-3").draggable({ cursor: "move", revert: "invalid", scroll: false });
    $("#0-4").draggable({ cursor: "move", revert: "invalid", scroll: false });
    $("#0-5").draggable({ cursor: "move", revert: "invalid", scroll: false });
    $("#0-6").draggable({ cursor: "move", revert: "invalid", scroll: false });
    $("#1-1").draggable({ cursor: "move", revert: "invalid", scroll: false });
    $("#1-2").draggable({ cursor: "move", revert: "invalid", scroll: false });
    $("#1-3").draggable({ cursor: "move", revert: "invalid", scroll: false });
    $("#1-4").draggable({ cursor: "move", revert: "invalid", scroll: false });
    $("#1-5").draggable({ cursor: "move", revert: "invalid", scroll: false });
    $("#1-6").draggable({ cursor: "move", revert: "invalid", scroll: false });
    $("#2-2").draggable({ cursor: "move", revert: "invalid", scroll: false });
    $("#2-3").draggable({ cursor: "move", revert: "invalid", scroll: false });
    $("#2-4").draggable({ cursor: "move", revert: "invalid", scroll: false });
    $("#2-5").draggable({ cursor: "move", revert: "invalid", scroll: false });
    $("#2-6").draggable({ cursor: "move", revert: "invalid", scroll: false });
    $("#3-3").draggable({ cursor: "move", revert: "invalid", scroll: false });
    $("#3-4").draggable({ cursor: "move", revert: "invalid", scroll: false });
    $("#3-5").draggable({ cursor: "move", revert: "invalid", scroll: false });
    $("#3-6").draggable({ cursor: "move", revert: "invalid", scroll: false });
    $("#4-4").draggable({ cursor: "move", revert: "invalid", scroll: false });
    $("#4-5").draggable({ cursor: "move", revert: "invalid", scroll: false });
    $("#4-6").draggable({ cursor: "move", revert: "invalid", scroll: false });
    $("#5-5").draggable({ cursor: "move", revert: "invalid", scroll: false });
    $("#5-6").draggable({ cursor: "move", revert: "invalid", scroll: false });
    $("#6-6").draggable({ cursor: "move", revert: "invalid", scroll: false });

    var $rBox = $("#rotateBox"),
        $firstPlace = $("#firstPlace"),
        $rightPlace = $("#right"),
        $leftPlace = $("#left");

    $firstPlace.droppable({
        helper: whichBoneToAccept,
        accept: whichBoneToAccept(),
        drop: function (event, ui) {
            $(function () {
                var value = $($firstPlace).data('canDrop');
                if (value == true) {
                    $($firstPlace).data('canDrop', false).attr('data-can-drop', false);
                    createHPlacesFor(ui.draggable);
                    var id = getURLParameter('id');
                    $.ajax({
                        type: "GET",
                        url: "handle_move/" + id,
                        data: { total_changes: ui.draggable.prop('id')},
                        success: function () {
                            alert("Success!");
                        }
                    });
                }
            });
        }
    });

    function whichBoneToAccept() {
        return $($firstPlace).data('whichDrop')
    }

    $rightPlace.droppable({
        drop: function (event, ui) {
            $(this)
                .find("div")
                .html("Moved!");
            createHPlacesFor(ui.draggable)
        }
    });

    $leftPlace.droppable({
        drop: function (event, ui) {
            $(this)
                .find("div")
                .html("Moved!");
            createHPlacesFor(ui.draggable)
        }
    });

    $rBox.droppable({
        drop: function (event, ui) {
            $(this)
                .find("p")
                .html("Dropped!");
            rotateBone(ui.draggable);
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

    function rotateBone($bone) {
        $bone
            .css({ "transform": "rotate(90deg)", "-webkit-transform": "rotate(90deg)", "-moz-transform": "rotate(90deg)" })
            .find("div")
            .fadeIn();
    }

    function getURLParameter(name) {
        var full_url = document.URL; // Get current url
        var url_array = full_url.split('/') // Split the string into an array with / as separator
        var last_segment = url_array[url_array.length-1];  // Get the last part of the array (-1)
        return last_segment
    }
});