//
//  SpotifyPlugin.m
//
#define kTokenSwapServiceURL "http://localhost:1234/swap"

// The URL to your token refresh endpoint
// If you don't provide a token refresh service url, the user will need to sign in again every time their token expires.

#define kTokenRefreshServiceURL "http://localhost:1234/refresh"


#define kSessionUserDefaultsKey "SpotifySession"


#import "SpotifyPlugin.h"
#import "SpotifyAudioPlayer.h"
#import <objc/runtime.h>

@interface SpotifyPlugin()<SPTAudioStreamingDelegate,SPTAudioStreamingPlaybackDelegate>
@property (nonatomic, strong) SPTAudioStreamingController *player;

@end;

@implementation SpotifyPlugin

- (void)myPluginMethod:(CDVInvokedUrlCommand*)command
{
    // Check command.arguments here.
}
//CDVViewController *mWebView;
- (id)init
{
    
    self = [super init];
}
-(void)login :(CDVInvokedUrlCommand*)command
{
    
    __weak SpotifyPlugin* weakSelf = self;
    NSLog(@"SpotifyPlugin - %@ - %@",[command.arguments objectAtIndex:0],[command.arguments objectAtIndex:1]);
    SPTAuth *auth = [SPTAuth defaultInstance];
    auth.clientID = [command.arguments objectAtIndex:0];
    auth.requestedScopes = @[SPTAuthStreamingScope];
    auth.redirectURL = [NSURL URLWithString:[command.arguments objectAtIndex:1]];
#ifdef kTokenSwapServiceURL
    auth.tokenSwapURL = [NSURL URLWithString:@kTokenSwapServiceURL];
#endif
#ifdef kTokenRefreshServiceURL
    auth.tokenRefreshURL = [NSURL URLWithString:@kTokenRefreshServiceURL];
#endif
    auth.sessionUserDefaultsKey = @kSessionUserDefaultsKey;
   NSString *responseType = @"token";
    
    __block id observer;
   
    [self.commandDelegate runInBackground:^{
        
        SPTAuthCallback callback = ^(NSError *error, SPTSession *session) {
            CDVPluginResult *pluginResult;
            
            if (error != nil) {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error.localizedDescription];
            } else {
                pluginResult = [CDVPluginResult
                                resultWithStatus:CDVCommandStatus_OK
                                ];
                auth.session = session;
            }
            
            [weakSelf.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        };
        
        observer = [[NSNotificationCenter defaultCenter]
                    addObserverForName:CDVPluginHandleOpenURLNotification
                    object:nil queue:nil usingBlock:^(NSNotification *note) {
                        NSURL *url = [note object];
                        SPTAuth *auth = [SPTAuth defaultInstance];
                        
                        if ([auth canHandleURL:url]) {
                            [auth handleAuthCallbackWithTriggeredAuthURL:url callback:callback];
                            return;
                        }
                        
                        
                        if ([responseType isEqualToString:@"token"])
                            return [[SPTAuth defaultInstance]
                                    handleAuthCallbackWithTriggeredAuthURL:url
                                    callback:callback];
                    }
                    ];
       
        [[UIApplication sharedApplication] openURL:auth.spotifyWebAuthenticationURL];
    }];
    [SpotifyAudioPlayer initialize];
    NSLog(@"token %@",[[[SPTAuth defaultInstance] session] accessToken] );
       if (self.player == nil) {
        NSError *error = nil;
        self.player = [SPTAudioStreamingController sharedInstance];
        if ([self.player startWithClientId:auth.clientID audioController:nil allowCaching:YES error:&error]) {
            self.player.delegate = self;
            self.player.playbackDelegate = self;
            self.player.diskCache = [[SPTDiskCache alloc] initWithCapacity:1024 * 1024 * 64];
            [self.player loginWithAccessToken:auth.session.accessToken];
            NSLog(@"SpotifyPlugin player init");
        } else {
            self.player = nil;
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error init" message:[error description] preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            
        }
    }

}
-(void)play:(CDVInvokedUrlCommand*)command
{
    NSString * str1 = [command.arguments objectAtIndex:0];
    NSLog(@"SpotifyPlayer track %@",str1);
   
    [self.player playSpotifyURI:str1 startingWithIndex:0 startingWithPosition:0 callback:^(NSError *error) {
        if (error != nil) {
            NSLog(@"*** failed to play: %@", error);
            return;
        }
    }];
}
-(void)pause:(CDVInvokedUrlCommand*)command
{
    NSLog(@"SpotifyPlayer action play/pause");
    [self.player setIsPlaying:!self.player.playbackState.isPlaying callback:nil];
}
-(void)next:(CDVInvokedUrlCommand*)command
{
    NSLog(@"SpotifyPlayer action next");
    [self.player skipNext:nil];
    [self myPluginMethod:command];
    
}
-(void)prev:(CDVInvokedUrlCommand*)command
{
    NSLog(@"SpotifyPlayer action prev");
    [self.player skipPrevious:nil];
}
-(void)logout:(CDVInvokedUrlCommand*)command
{
    NSLog(@"SpotifyPlayer action logout");
    if (self.player) {
        [self.player setIsPlaying:NO callback:nil];
        //[self.player logout];
        SPTAuth *auth = [SPTAuth defaultInstance];
       [[UIApplication sharedApplication] openURL:auth.spotifyWebAuthenticationURL];
    }
}
-(void)seek:(CDVInvokedUrlCommand*)command
{
    
    
    NSTimeInterval offset = ((NSNumber *)[command.arguments objectAtIndex:0]).doubleValue;
    offset=self.player.metadata.currentTrack.duration * offset/100;
    [self.commandDelegate runInBackground:^{
                    
            
        
            [self.player seekTo:offset callback:^(NSError *error) {
                CDVPluginResult *pluginResult;
                
                if (error != nil) {
                    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: error.localizedDescription];
                } else {
                    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
                }
                
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            }];
        }];
    NSMutableString *str = [NSMutableString stringWithString:@"Spotify.Events.onAudioFlush(["];
    [str appendFormat:@"%f])",offset];
    
    [self.commandDelegate evalJs:str];

    NSLog(@"SpotifyPlayer action seek %f ms",offset);
}
-(void)volume:(CDVInvokedUrlCommand*)command
{
    NSLog(@"SpotifyPlayer action volume%@", [command.arguments objectAtIndex:0]);

    [self.commandDelegate runInBackground:^{
        
        
            SPTVolume volume = [[command.arguments objectAtIndex:0] doubleValue];
        volume/=100;
            [self.player setVolume:volume callback:^(NSError *error) {
                CDVPluginResult *pluginResult;
                
                if (error != nil) {
                    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: error.localizedDescription];
                } else {
                    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
                }
                
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            }];
        }];
   

}
/////////////////////////////////////////////////////////////////
//                          EVENTS                             //
 ////////////////////////////////////////////////////////////////

- (void)audioStreaming:(SPTAudioStreamingController *)audioStreaming didChangePlaybackStatus:(BOOL)isPlaying {
    NSLog(@"is playing = %d", isPlaying);
    
    if (isPlaying) {
        
        [self.commandDelegate evalJs:@"Spotify.Events.onPlay(['Player play'])"];
       
    } else {
       [self.commandDelegate evalJs:@"Spotify.Events.onPause(['Player paused'])"];
    }
}


-(void)audioStreaming:(SPTAudioStreamingController *)audioStreaming didChangeMetadata:(SPTPlaybackMetadata *)metadata {
    [self.commandDelegate evalJs:@"Spotify.Events.onTrackChanged(['Track changed'])"];
    NSMutableString *str = [NSMutableString stringWithString:@"Spotify.Events.onMetadataChanged(["];
    [str appendFormat:@"'%@',",metadata.currentTrack.name ];
    [str appendFormat:@"'%@',",metadata.currentTrack.artistName ];
    [str appendFormat:@"'%@',",metadata.currentTrack.albumName ];
    [str appendFormat:@"%f])",metadata.currentTrack.duration ];
    [self.commandDelegate evalJs:str];
}

-(void)audioStreaming:(SPTAudioStreamingController *)audioStreaming didReceivePlaybackEvent:(SpPlaybackEvent)event withName:(NSString *)name {
    NSLog(@"didReceivePlaybackEvent: %zd %@", event, name);
    NSLog(@"isPlaying=%d isRepeating=%d isShuffling=%d isActiveDevice=%d positionMs=%f",
          self.player.playbackState.isPlaying,
          self.player.playbackState.isRepeating,
          self.player.playbackState.isShuffling,
          self.player.playbackState.isActiveDevice,
          self.player.playbackState.position);
}
-(void)audioStreamingDidSkipToNextTrack:(SPTAudioStreamingController *)audioStreaming
{
    [self.commandDelegate evalJs:@"Spotify.Events.onNext(['Next trak'])"];
}
-(void)audioStreamingDidSkipToPreviousTrack:(SPTAudioStreamingController *)audioStreaming
{
    [self.commandDelegate evalJs:@"Spotify.Events.onPrev(['Previos trak'])"];
}
-(void)audioStreaming:(SPTAudioStreamingController *)audioStreaming didChangeToTrack:(NSDictionary *)trackMetadata
{
    if(trackMetadata != nil){
        [self.commandDelegate evalJs:@"Spotify.Events.onTrackChanged(['Track changed'])"];
    }
}
-(void)audioStreaming:(SPTAudioStreamingController *)audioStreaming didSeekToOffset:(NSTimeInterval)offset
{
   // [self.commandDelegate evalJs:@"alert('!')"];
}
- (void)audioStreaming:(SPTAudioStreamingController *)audioStreaming didChangePosition:(NSTimeInterval)position {
    NSMutableString *str = [NSMutableString stringWithString:@"Spotify.Events.onPosition("];
    [str appendFormat:@"%f)",position*1000];
    
    [self.commandDelegate evalJs:str];
    
}
-(void)audioStreaming:(SPTAudioStreamingController *)audioStreaming didChangeVolume:(SPTVolume)volume
{
    NSMutableString *str = [NSMutableString stringWithString:@"Spotify.Events.onVolumeChanged("];
    [str appendFormat:@"%f)",volume];
    
    [self.commandDelegate evalJs:str];

}
@end
