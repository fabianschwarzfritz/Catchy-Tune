//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
//
//= require application

// Initalize handlers when document is completely loaded
$(document).ready(function () {
    // cache ui elements for performance reasons
    player = $("#player")[0];
    play_pause_btn = $("#play");
    next_btn = $("#next");
    volume_up_btn = $("#volumeup");
    volume_down_btn = $("#volumedown");
    player_progressbar = $("#playprogressbar");
    current_song_info = $('#currentinfo');

    initHandlers();

    state = "stopped";
});

var play_pause_btn;
var next_btn;
var volume_up_btn;
var volume_down_btn;
var player;
var player_progressbar;
var current_song_info;

var state;

// Initialize all ui handlers
function initHandlers() {
    play_pause_btn.click(function () {
        actionPlayPause();
    });
    next_btn.click(function () {
        actionNextSong();
    });
    volume_up_btn.click(function () {
        actionVolumeUp();
    });
    volume_down_btn.click(function () {
        actionVolumeDown();
    });
}

// Initialize audio player event listeners
function initAudioEventListeners() {
    player.addEventListener("timeupdate", actionTimeUpdate, true);
    player.addEventListener("ended", actionSongEnded, true);
}

// Action triggered when play/pause is pressed
function actionPlayPause() {
    switch (state) {
        case "stopped":
            updateSong();
            if (state != "stopped") {
                play();
            }
            break;
        case "playing":
            pause();
            break;
        case "paused":
            play();
            break;
    }
}

// Action triggered when next song is pressed
function actionNextSong() {
    nextSong();
}

// Action triggered when volume up is pressed
function actionVolumeUp() {
    if (player.volume < 0.9)
        player.volume += 0.1;
    else
        player.volume = 1.0;
}

// Action triggered when volume down is pressed
function actionVolumeDown() {
    if (player.volume > 0.1)
        player.volume -= 0.1;
    else
        player.volume = 0.0;
}

// Action triggered when a time update occurs
function actionTimeUpdate() {
    if (state == "playing") {
        var current = player.currentTime;
        var duration = player.duration;
        var currentPercentage = current / duration * 100;
        player_progressbar.width(currentPercentage + "%");
    }
}

// Action triggered when the song which is currently playing ends
function actionSongEnded() {
    nextSong();
}

// Skip current song and set to next song to current song
function nextSong() {
    stop();
    syncRequest("/playlist/next");
    updateSong();
    if (state != "stopped") {
        play();
    }
}

// Updates the song: fetch new song information and set song to audio element
function updateSong() {
    var currentSong = currentSongId();

    if (/\S/.test(currentSong)) {
        fetchCurrentSongFile(currentSong);
        initAudioEventListeners();
        state = "paused";
    } else {
        // current song id is empty or contains only whitespaces
        stop();
    }

    fetchCurrentSongInformation();
}

function play() {
    player.play();

    var progressbar_container = player_progressbar.parent()[0];
    if (!progressbar_container.classList.contains("active")) {
        progressbar_container.classList.add("active");
    }

    play_pause_btn.html("<i class='icon-pause'></i>");
    state = "playing";
}

function pause() {
    player.pause();

    var progressbar_container = player_progressbar.parent()[0];
    if (progressbar_container.classList.contains("active")) {
        progressbar_container.classList.remove("active");
    }

    play_pause_btn.html("<i class='icon-play'></i>");
    state = "paused";
}

function stop() {
    if (/\S/.test(player.getAttribute("src"))) {
        player.pause();
    }

    player_progressbar.width("0%");

    play_pause_btn.html("<i class='icon-play'></i>");
    state = "stopped";
}

// Fetch song information of current song
function fetchCurrentSongInformation() {
    current_song_info.load('/playlist/current_song');
}

// Fetch stream file of current song
function fetchCurrentSongFile(currentsongid) {
    player.src = "/playlist/stream?track_id=" + currentsongid;
}

function currentSongId() {
    return syncRequest("/playlist/current_song.text", "get");
}

function addSong(song_id) {
    data = {"track_id": song_id};
    $.ajax({
        url: "/playlist/add",
        type: "post",
        data: data,
        async: false,
        success: function (data) {
            if (state == "stopped") {
                actionPlayPause();
            }
        }
    });
}

function addArtist(artist_id) {
    data = {"artist_id": artist_id};
    $.ajax({
        url: "/playlist/add",
        type: "post",
        data: data,
        async: false,
        success: function (data) {
            if (state == "stopped") {
                actionPlayPause();
            }
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




