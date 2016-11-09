cordova.define("com.timflapper.spotify.auth", function(require, exports, module) {
var exec = require('cordova/exec');
});
var Spotify = {
    login : function(a,b) {
        cordova.exec(
                     function() {},
                     function() {},
                     "SpotifyPlugin",
                     "login",
                     [a,b]
                     )
    },
play:function(val){
    cordova.exec(
                 function() {},
                 function() {},
                 "SpotifyPlugin",
                 "play",
                 [val]
                 )
},
    pause : function(){
        cordova.exec(
                     function(){},
                     function(){},
                     "SpotifyPlugin",
                     "pause",
                     []
        )
    },
    next : function(){
        cordova.exec(
                     function(){},
                     function(){},
                     "SpotifyPlugin",
                     "next",
                     []
                     )
    },
    prev : function(){
        cordova.exec(
                     function(){},
                     function(){},
                     "SpotifyPlugin",
                     "prev",
                     []
                     )
    },
    logout : function(){
        cordova.exec(
                     function(){},
                     function(){},
                     "SpotifyPlugin",
                     "logout",
                     []
                     )
    },
    seek : function(val){
        cordova.exec(
                     function(){},
                     function(){},
                     "SpotifyPlugin",
                     "seek",
                     [val]
                     )
    },
    setVolume : function(val){
        cordova.exec(
                     function(){},
                     function(){},
                     "SpotifyPlugin",
                     "volume",
                     [val]
                     )
    },
    Events : {
        onPlayerPlay : function(args){},
        onMetadataChanged :function(args){},
        onPrev : function(args){
            //arg[0] - action
        },
        onNext : function(args){
            //arg[0] - action
        },
        onPause : function(args){
            //arg[0] - action
        },
        onPlay : function(args){
            //arg[0] - action
        },
        onAudioFlush : function(arg){
            //arg[0] - position (ms)
        },
        onTrackChanged : function(arg){
            //arg[0] - action
        },
        onPosition : function(arg){
            //arg[0] - position ms
        },
        onVolumeChanged : function(arg){
            //arg - volume betwen 0.0 ....1.0
        }
        
    }
    
};
module.exports =Spotify;
