//
//  HHAudioPlayer.h
//  HHChatKit
//
//  Created by Henry on 2020/8/16.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHAudioPlayer : NSObject

@property (nonatomic, assign, readonly) BOOL isPlaying;

+ (HHAudioPlayer *)sharedAudioPlayer;

- (void)playAudioAtPath:(NSString *)path complete:(void (^)(BOOL finished))complete;

- (void)stopPlayingAudio;

@end

NS_ASSUME_NONNULL_END
