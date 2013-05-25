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
        var currentSong = currentSongId();
        updateSong(currentSong);
    }
    togglePlayPause();
}

// Action triggered when next song is pressed
function actionNextSong() {
    var isplaying = !getPlayer().paused;
    setPause();
    nextSong();
    var currentSong = currentSongId();
    updateSong(currentSong);
    setStatus(isplaying);
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
    actionNextSong();
}

// Updates the song: fetch new song information and set song to audio element
function updateSong(songid) {
    fetchCurrentSongFile(songid);
    fetchCurrentSongInformation();
    initAudioEventListeners();
}

// Toggle between play and pause
function togglePlayPause() {
    if (getPlayer().paused) {
        setPlay();
        return;
    }
    setPause();
}

function setStatus(play) {
    if (play) {
        setPlay();
        return;
    }
    setPause();
}

function setPlay() {
    getPlayer().play();
    if (!$("#playprogressbar").parent()[0].classList.contains("active")) {
        $("#playprogressbar").parent()[0].classList.add("active");
    }
    $("#play")[0].textContent = "||";
}

function setPause() {
    getPlayer().pause();
    if ($("#playprogressbar").parent()[0].classList.contains("active")) {
        $("#playprogressbar").parent()[0].classList.remove("active");
    }
    $("#play")[0].textContent = ">";
}

// Fetch song information of current song
function fetchCurrentSongInformation() {
    $('#currentinfo').load('/playlist/showcurrentsong');
}

// Fetch stream file of current song
function fetchCurrentSongFile(currentsongid) {
    getPlayer().src = "/playlist/stream?songid=" + currentsongid;
}

function currentSongId() {
    return syncRequest("/playlist/current_song.text", "get");
}

// Skip current song and set to next song to current song
function nextSong() {
    syncRequest("/playlist/next");
}

function addSong(songid) {
    data = {"songid": songid};
    $.ajax({
        url: "/playlist/add",
        type: "post",
        data: data,
        async: false,
        success: function (data) {
        }
    });
}

function syncRequest(url, type) {
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




