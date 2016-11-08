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
        
        var session, player;
        
        var urlScheme = 'iostestshema';
        var clientId = '50ef88bdcdd3441f94ec7e1f2fb781a6';
        
        function onDeviceReady() {
            spotify.authenticate(urlScheme, clientId, 'token', authDone);
        }
        
        function authDone(error, sess) {
            if (error) return console.log("ERROR!", error);
            
            console.log(sess);
            
            session = sess;
            
            player = spotify.createAudioPlayer(clientId);
            
            player.login(session, function(error) {
                         if (error) return console.log(error);
                         
                         player.play('spotify:track:2DlfLPbXH5ncf56Nytxd4w', function(error) {
                                     if (error) return console.log(error);
                                     });
                         });
        }
        
        document.addEventListener('deviceready', onDeviceReady, false);
    }
};

app.initialize();
