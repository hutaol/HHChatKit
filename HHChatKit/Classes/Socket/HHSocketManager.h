//
//  HHSocketManager.h
//  HHChatKit
//
//  Created by Henry on 2020/8/19.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HHSocketManagerDelegate <NSObject>



@end

@interface HHSocketManager : NSObject

@property (nonatomic, weak) id <HHSocketManagerDelegate> delegate;

+ (instancetype)shareManager;

- (void)connect:(NSString *)url;

- (void)disconnect;

- (void)subscribeTo:(NSString *)destination;

- (void)sendTo:(NSString *)destination body:(NSString *)body;

@end

NS_ASSUME_NONNULL_END
