//
//  HHAudioPlayer.m
//  HHChatKit
//
//  Created by Henry on 2020/8/16.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface HHAudioPlayer() <AVAudioPlayerDelegate>

@property (nonatomic, strong) void (^completeBlock)(BOOL finished);

@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation HHAudioPlayer

+ (HHAudioPlayer *)sharedAudioPlayer {
    static HHAudioPlayer *audioPlayer;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        audioPlayer = [[HHAudioPlayer alloc] init];
    });
    return audioPlayer;
}

- (void)playAudioAtPath:(NSString *)path complete:(void (^)(BOOL finished))complete {
    
    // play current 外放
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];

    if (self.player && self.player.isPlaying) {
        [self stopPlayingAudio];
    }
    self.completeBlock = complete;
    NSError *error;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:&error];
    self.player.delegate = self;
    if (error) {
        if (complete) {
            complete(NO);
        }
        return;
    }
    [self.player play];
}

- (void)stopPlayingAudio {
    [self.player stop];
    if (self.completeBlock) {
        self.completeBlock(NO);
    }
}

- (BOOL)isPlaying {
    if (self.player) {
        return self.player.isPlaying;
    }
    return NO;
}

#pragma mark - # Delegate
//MARK: AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if (self.completeBlock) {
        self.completeBlock(YES);
        self.completeBlock = nil;
    }
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    NSLog(@"音频播放出现错误：%@", error);
    if (self.completeBlock) {
        self.completeBlock(NO);
        self.completeBlock = nil;
    }
}


@end
