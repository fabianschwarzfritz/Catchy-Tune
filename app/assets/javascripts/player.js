//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

// Initalize handlers when document is completely loaded
$(document).ready(function () {
    initHandler();
});

// Initialize all ui handlers
function initHandler() {
    $("#play").click(function () {
        actionPlayPause();
    });
}

// Returns the player audio element
function getPlayer() {
    return document.getElementById('player');
}

// Action triggered when play/pause is pressed
function actionPlayPause() {
    if (getPlayer().getAttribute("src") == "") {
        fetchNextSong();
        initAudioEventListeners();
    }
    togglePlayPause();
}

// Toggle between play and pause
function togglePlayPause() {
    if (getPlayer().paused) {
        getPlayer().play();
    } else {
        getPlayer().pause();
    }
}

// Fetch next song and prepare audio element for playing
function fetchNextSong() {

}




