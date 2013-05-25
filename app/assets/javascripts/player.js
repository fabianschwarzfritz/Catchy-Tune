//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
//
//= require application

// Initalize handlers when document is completely loaded
$(document).ready(function () {
    initHandler();
});

// Initialize all ui handlers
function initHandler() {
    $("#play").click(function () {
        actionPlayPause();
    });
    $("#next").click(function () {
        actionNextSong();
    });
    $("#volumeup").click(function () {
        actionVolumeUp();
    });
    $("#volumedown").click(function () {
        actionVolumeDown();
    });
}

// Initialize audio player event listeners
function initAudioEventListeners() {
    getPlayer().addEventListener("timeupdate", actionTimeUpdate, true);
    getPlayer().addEventListener("ended", actionSongEnded, true);
}

// Returns the player audio element
function getPlayer() {
    return document.getElementById("player");
}

// Action triggered when play/pause is pressed
function actionPlayPause() {
    if (getPlayer().getAttribute("src") == "") {
        fetchCurrentSongFile();
        fetchCurrentSongInformation();
        initAudioEventListeners();
    }
    togglePlayPause();
}

// Action triggered when next song is pressed
function actionNextSong() {
    nextSong();
}

// Action triggered when volume up is pressed
function actionVolumeUp() {
    var volume = getPlayer().volume;
    volume += 0.1;
    getPlayer().volume = volume;
}

// Action triggered when volume down is pressed
function actionVolumeDown() {
    var volume = getPlayer().volume;
    volume -= 0.1;
    getPlayer().volume = volume;
}

function actionTimeUpdate() {
    var current = getPlayer().currentTime;
    var fullTime = getPlayer().duration;
    var onePercent = fullTime / 100;
    var currentPercentage = current / onePercent;
    $("#playprogressbar").width(currentPercentage + "%");
}

function actionSongEnded() {
    getPlayer().pause();
    $("#play").html('play');
    nextSong();
    if (currentSongId() != null) {
        fetchCurrentSongFile();
        fetchCurrentSongInformation()
        initAudioEventListeners();
        getPlayer().play();
    }
}

// Toggle between play and pause
function togglePlayPause() {
    if (getPlayer().paused) {
        getPlayer().play();

        if(!$("#playprogressbar").parent()[0].classList.contains("active")) {
            $("#playprogressbar").parent()[0].classList.add("active");
        }

        $("#play")[0].textContent = "pause";

    } else {
        getPlayer().pause();

        if($("#playprogressbar").parent()[0].classList.contains("active")) {
            $("#playprogressbar").parent()[0].classList.remove("active");
        }

        $("#play")[0].textContent = "play";
    }
}

// Fetch song information of current song
function fetchCurrentSongInformation() {
    var current_song_id = currentSongId();
    $('#currentinfo').load('/playlist/showcurrentsong');
}

// Fetch stream file of current song
function fetchCurrentSongFile() {
    var current_song_id = currentSongId();
    getPlayer().src = "/playlist/stream?songid=" + current_song_id;
}

function currentSongId() {
    var result = null;
    var scriptUrl = "/playlist/current_song.text";
    $.ajax({
        url: scriptUrl,
        type: 'get',
        dataType: 'text',
        async: false,
        success: function (data) {
            result = data;
        }
    });
    return result;
}

// Skip current song and set to next song to current song
function nextSong() {
    $.get("/playlist/next", function (data) {
    });
}

function addSong(songid) {
    data = {"songid": songid};
    $.post("/playlist/add", data, function (data) {
        alert("addsong; " + data);
    }, "json");
}




