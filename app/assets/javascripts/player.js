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
        updateSong();
    }
    togglePlayPause();
}

// Action triggered when next song is pressed
function actionNextSong() {
    togglePlayPause();
    nextSong();
    updateSong();
    togglePlayPause();
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

// Action triggered when a time update occurs
function actionTimeUpdate() {
    var current = getPlayer().currentTime;
    var fullTime = getPlayer().duration;
    var onePercent = fullTime / 100;
    var currentPercentage = current / onePercent;
    $("#playprogressbar").width(currentPercentage + "%");
}

// Action triggered when the song which is currently playing ends
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

// Updates the song: fetch new song information and set song to audio element
function updateSong() {
    fetchCurrentSongFile();
    fetchCurrentSongInformation();
    initAudioEventListeners();
}

// Toggle between play and pause
function togglePlayPause() {
    if (getPlayer().paused) {
        getPlayer().play();

        if (!$("#playprogressbar").parent()[0].classList.contains("active")) {
            $("#playprogressbar").parent()[0].classList.add("active");
        }

        $("#play")[0].textContent = "||";

    } else {
        getPlayer().pause();

        if ($("#playprogressbar").parent()[0].classList.contains("active")) {
            $("#playprogressbar").parent()[0].classList.remove("active");
        }

        $("#play")[0].textContent = ">";
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
    return syncGet("/playlist/current_song.text", "get");
}

// Skip current song and set to next song to current song
function nextSong() {
    syncGet("/playlist/next");
}

function addSong(songid) {
    data = {"songid": songid};
    $.post("/playlist/add", data, function (data) {
        alert("addsong; " + data);
    }, "json");
}

function syncGet(url, type) {
    var result = null;
    $.ajax({
        url: url,
        type: type,
        dataType: 'text',
        async: false,
        success: function (data) {
            result = data;
        }
    });
    return result;
}




