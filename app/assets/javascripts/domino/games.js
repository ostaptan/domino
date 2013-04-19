$(function () {
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
                    var id = getURLid();
                    $.ajax({
                        type: "GET",
                        url: "handle_move/" + id,
                        data: { bone_num: ui.draggable.prop('id')},
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

    function getURLid() {
        var full_url = document.URL; // Get current url
        var url_array = full_url.split('/'); // Split the string into an array with / as separator
        return url_array[url_array.length-1];  // Get the last part of the array (-1)
    }
});