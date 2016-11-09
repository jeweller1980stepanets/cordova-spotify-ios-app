//
//  SpotifyAudioPlayer.m
//  SpotifyPlugin
//
//  Created by Tim Flapper on 08/05/14.
//
//

#import "SpotifyAudioPlayer.h"

@interface SpotifyAudioPlayer()
@property (nonatomic, strong) SPTAudioStreamingController* player;
@end

@implementation SpotifyAudioPlayer
static NSMutableDictionary *instances;

@synthesize delegate, playbackDelegate;
/*
 + (void)initialize
 {
     NSLog(@"SpotifyAudioPlayer init");
 if (self == [SpotifyAudioPlayer class]) {
 instances = [NSMutableDictionary new];
     
 }
 }
 
 + (instancetype)getInstanceByID:(NSString *)ID
 {
 return [instances objectForKey: ID];
 }
 
 - (id)initWithClientId:(NSString *)clientId audioController:(SPTCoreAudioController *)audioController
 {
     NSLog(@"SpotifyAudioPlayer initWithClientId");
//=======================
     SPTAuth *auth = [SPTAuth defaultInstance];
     NSError *error = nil;
     
     if (self.player == nil) {
         NSError *error = nil;
         self.player = [SPTAudioStreamingController sharedInstance];
         if ([self.player startWithClientId:auth.clientID audioController:nil allowCaching:YES error:&error]) {
             self.player.delegate = self;
             self.player.playbackDelegate = self;
             self.player.diskCache = [[SPTDiskCache alloc] initWithCapacity:1024 * 1024 * 64];
             [self.player loginWithAccessToken:auth.session.accessToken];
         } else {
             self.player = nil;
             UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error init" message:[error description] preferredStyle:UIAlertControllerStyleAlert];
             [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            
         }
     }

 //======================
  /*   self = [super  initWithClientId:clientId audioController:audioController];
 
 if (self) {
 delegate = self;
 playbackDelegate = self;
 
 _instanceID = [NSString stringWithFormat:@"%d", (int)instances.count+1];
 [instances setObject:self
 forKey: _instanceID];
 }*/
 /*
 return self;
 }
 
 - (void)dispatchEvent:(NSString *)type
 {
 [self dispatchEvent:type withArguments:@[]];
 }
 
 - (void)dispatchEvent:(NSString *)type withArguments:(NSArray *)args
 {
 
 NSDictionary *info = @{@"type": type,
 @"args": args};
 
 NSNotification *note = [NSNotification notificationWithName:@"event" object:self userInfo:info];
 
 [[NSNotificationCenter defaultCenter] postNotification:note];
 }
 
 -(void)audioStreamingDidLogin:(SPTAudioStreamingController *)audioStreaming
 {
 [self dispatchEvent:@"login"];
 }
 
 -(void)audioStreamingDidLogout:(SPTAudioStreamingController *)audioStreaming
 {
 [self dispatchEvent:@"logout"];
 }
 
 -(void)audioStreamingDidLosePermissionForPlayback:(SPTAudioStreamingController *)audioStreaming
 {
 [self dispatchEvent:@"permissionLost"];
 }
 
 -(void)audioStreamingDidBecomeActivePlaybackDevice:(SPTAudioStreamingController *)audioStreaming
 {
 [self dispatchEvent:@"active"];
 }
 
 -(void)audioStreamingDidBecomeInactivePlaybackDevice:(SPTAudioStreamingController *)audioStreaming
 {
 [self dispatchEvent:@"inactive"];
 }
 
 -(void)audioStreamingDidEncounterTemporaryConnectionError:(SPTAudioStreamingController *)audioStreaming
 {
 [self dispatchEvent:@"temporaryConnectionError"];
 }
 
 -(void)audioStreaming:(SPTAudioStreamingController *)audioStreaming didChangePlaybackStatus:(BOOL)isPlaying
 {
 [self dispatchEvent:@"playbackStatus" withArguments:@[[NSNumber numberWithBool:isPlaying]]];
 }
 
 -(void)audioStreaming:(SPTAudioStreamingController *)audioStreaming didChangeRepeatStatus:(BOOL)isRepeated
 {
 [self dispatchEvent:@"repeatStatus" withArguments:@[[NSNumber numberWithBool:isRepeated]]];
 }
 
 -(void)audioStreaming:(SPTAudioStreamingController *)audioStreaming didChangeShuffleStatus:(BOOL)isShuffled
 {
 [self dispatchEvent:@"shuffleStatus" withArguments:@[[NSNumber numberWithBool:isShuffled]]];
 }
 
 -(void)audioStreaming:(SPTAudioStreamingController *)audioStreaming didChangeToTrack:(NSDictionary *)trackMetadata
 {
 if(trackMetadata != nil){
 [self dispatchEvent:@"trackChanged" withArguments:@[trackMetadata]];
 }
 }
 
 -(void)audioStreaming:(SPTAudioStreamingController *)audioStreaming didChangeVolume:(SPTVolume)volume
 {
 [self dispatchEvent:@"volumeChanged" withArguments:@[[NSNumber numberWithDouble:volume]]];
 }
 
 -(void)audioStreaming:(SPTAudioStreamingController *)audioStreaming didEncounterError:(NSError *)error
 {
 [self dispatchEvent:@"error" withArguments:@[error.localizedDescription]];
 }
 
 -(void)audioStreaming:(SPTAudioStreamingController *)audioStreaming didReceiveMessage:(NSString *)message
 {
 [self dispatchEvent:@"message" withArguments:@[message]];
 }
 
 -(void)audioStreaming:(SPTAudioStreamingController *)audioStreaming didSeekToOffset:(NSTimeInterval)offset
 {
 [self dispatchEvent:@"seekToOffset" withArguments:@[[NSNumber numberWithDouble:offset]]];
 }
 
 -(void)audioStreamingDidSkipToNextTrack:(SPTAudioStreamingController *)audioStreaming
 {
 [self dispatchEvent:@"skippedToNextTrack"];
 }
 
 -(void)audioStreamingDidSkipToPreviousTrack:(SPTAudioStreamingController *)audioStreaming
 {
 [self dispatchEvent:@"skippedToPreviousTrack"];
 }
*/
@end
