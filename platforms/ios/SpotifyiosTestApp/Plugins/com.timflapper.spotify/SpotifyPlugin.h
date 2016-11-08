//
//  SpotifyPlugin.h
//

#import "Cordova/CDV.h"
#import <SpotifyAudioPlayback/SpotifyAudioPlayback.h>
#import <SpotifyAuthentication/SpotifyAuthentication.h>
#import <SpotifyMetadata/SpotifyMetadata.h>
#import "SpotifyAudioPlayer.h"
#import <WebKit/WebKit.h>

NSString *dateToString(NSDate *date);
NSDate *stringToDate(NSString *dateString);

@interface SpotifyPlugin : CDVPlugin
-(void)login :(CDVInvokedUrlCommand*)command;
-(void)play:(CDVInvokedUrlCommand*)command;
-(void)pause:(CDVInvokedUrlCommand*)command;
-(void)next:(CDVInvokedUrlCommand*)command;
-(void)prev:(CDVInvokedUrlCommand*)command;
-(void)logout:(CDVInvokedUrlCommand*)command;
-(void)seek:(CDVInvokedUrlCommand*)command;
-(void)volume:(CDVInvokedUrlCommand*)command;
/* Linked to SPTAuth */
- (void)dispatchEvent:(NSString *)type;
-(void)audioStreaming:(SPTAudioStreamingController *)audioStreaming didChangeToTrack:(NSDictionary *)trackMetadata;
- (void)dispatchEvent:(NSString *)type withArguments:(NSArray *)args;
@end
