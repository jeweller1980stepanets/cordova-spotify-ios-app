cordova.define('cordova/plugin_list', function(require, exports, module) {
module.exports = [
    {
        "id": "com.timflapper.spotify.auth",
        "file": "plugins/com.timflapper.spotify/www/spotify/auth.js",
        "pluginId": "com.timflapper.spotify",
        "merges": [
            "spotify"
        ]
    },
    {
        "id": "com.timflapper.spotify.request",
        "file": "plugins/com.timflapper.spotify/www/spotify/request.js",
        "pluginId": "com.timflapper.spotify",
        "merges": [
            "spotify"
        ]
    },
    {
        "id": "com.timflapper.spotify.audio-player",
        "file": "plugins/com.timflapper.spotify/www/spotify/audio-player.js",
        "pluginId": "com.timflapper.spotify",
        "merges": [
            "spotify"
        ]
    },
    {
        "id": "com.timflapper.spotify.remote",
        "file": "plugins/com.timflapper.spotify/www/lib/remote.js",
        "pluginId": "com.timflapper.spotify"
    },
    {
        "id": "com.timflapper.spotify.utils",
        "file": "plugins/com.timflapper.spotify/www/lib/utils.js",
        "pluginId": "com.timflapper.spotify"
    },
    {
        "id": "com.timflapper.spotify.event-dispatcher",
        "file": "plugins/com.timflapper.spotify/www/lib/event-dispatcher.js",
        "pluginId": "com.timflapper.spotify"
    },
    {
        "id": "com.timflapper.spotify.vendors/reqwest",
        "file": "plugins/com.timflapper.spotify/www/vendors/reqwest/reqwest.min.js",
        "pluginId": "com.timflapper.spotify"
    }
];
module.exports.metadata = 
// TOP OF METADATA
{
    "cordova-plugin-whitelist": "1.3.0",
    "com.timflapper.spotify": "0.1.0"
};
// BOTTOM OF METADATA
});