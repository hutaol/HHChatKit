//
//  HHRequest.h
//  HHChatKit
//
//  Created by Henry on 2020/8/19.
//  Copyright © 2020 Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HHReqeustSuccess)(NSString *msg, id response);

typedef void(^HHRequestFailure)(NSInteger code, NSString *msg);

#define BASEURL @"http://172.16.2.60:8091"

@interface HHRequest : NSObject

+ (NSString *)getCompleteUrl:(NSString *)url;


+ (void)POST:(NSString *)url parameters:(nullable NSDictionary *)parameters success:(nullable HHReqeustSuccess)success failure:(nullable HHRequestFailure)failure;

+ (void)GET:(NSString *)url parameters:(nullable NSDictionary *)parameters success:(nullable HHReqeustSuccess)success failure:(nullable HHRequestFailure)failure;


@end

NS_ASSUME_NONNULL_END
