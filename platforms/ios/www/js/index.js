/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
var app = {
    // Application Constructor
    initialize: function() {
        document.addEventListener('deviceready', this.onDeviceReady.bind(this), false);
    },

    // deviceready Event Handler
    //
    // Bind any cordova events here. Common events are:
    // 'pause', 'resume', etc.
    onDeviceReady: function() {
        this.receivedEvent('deviceready');
    },

    // Update DOM on a Received Event
    receivedEvent: function(id) {
        var parentElement = document.getElementById(id);
        var listeningElement = parentElement.querySelector('.listening');
        var receivedElement = parentElement.querySelector('.received');

        listeningElement.setAttribute('style', 'display:none;');
        receivedElement.setAttribute('style', 'display:block;');

        console.log('Received Event: ' + id);
        Spotify.Events.onPlayerPlay = function(){alert('!')};
        document.getElementById('log').addEventListener('click',function(){Spotify.login("50ef88bdcdd3441f94ec7e1f2fb781a6","iostestshema://callback")});
        document.getElementById('playAlbum').addEventListener('click',function(){Spotify.play("spotify:album:75Sgdm3seM5KXkEd46vaDb")});
        document.getElementById('playPlaylist').addEventListener('click',function(){Spotify.play("spotify:user:spotify:playlist:2yLXxKhhziG2xzy7eyD4TD")});
        document.getElementById('playTrack').addEventListener('click',function(){Spotify.play("spotify:track:3qRNQHagYiiDLdWMSOkPGG")});
        document.getElementById('pause').addEventListener('click',function(){Spotify.pause()});
        document.getElementById('next').addEventListener('click',function(){Spotify.next()});
        document.getElementById('prev').addEventListener('click',function(){Spotify.prev()});
        document.getElementById('logout').addEventListener('click',function(){Spotify.logout()});
        //slider_seek
        document.getElementById('slider_seek').addEventListener('click',function(e){
                                                                var valX =(e.offsetX)*100/220;
                                                                var val = Math.floor(valX);
                                                                Spotify.seek(val)});
        //slider_volume
        document.getElementById('slider_volume').addEventListener('click',function(e){
         var valX = (e.offsetX)*100/220;
         Spotify.setVolume(valX)});
    }
};

app.initialize();
