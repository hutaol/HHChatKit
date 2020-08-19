//
//  HHRequest.m
//  HHChatKit
//
//  Created by Henry on 2020/8/19.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHRequest.h"
#import "HHNetworkHelper.h"

@implementation HHRequest

+ (NSString *)getCompleteUrl:(NSString *)url {
    if (!url || url.length == 0) {
        return nil;
    }
    if ([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) {//url是完整的路径
        return url;
    }
    
    NSString *completeUrl = nil;
    
    // TODO
    if ([url hasPrefix:@"/"]) {
        completeUrl = [NSString stringWithFormat:@"%@%@", BASEURL, url];
    } else {
        completeUrl = [NSString stringWithFormat:@"%@/%@", BASEURL, url];
    }
    return completeUrl;
}

+ (void)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(HHReqeustSuccess)success failure:(HHRequestFailure)failure {
    
#ifdef DEBUG
    [HHNetworkHelper openLog];
#else
    [HHNetworkHelper closeLog];
#endif
    
    // TODO token
    NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:parameters];
//    if (YYTUserInfo.access_token) {
//        [mDic setObject:YYTUserInfo.access_token forKey:@"access_token"];
//    }
    
    [mDic setObject:@"81f58a18a77b31141f514f0bd4b2c910a7" forKey:@"access_token"];

    url = [self getCompleteUrl:url];
    
    NSLog(@"HHNetworkHelper: %@", url);

    [HHNetworkHelper setRequestSerializer:HHRequestSerializerJSON];
    [HHNetworkHelper setResponseSerializer:HHResponseSerializerJSON];
    
    [HHNetworkHelper POST:url parameters:mDic success:^(id  _Nonnull response) {
        
        // TODO
//        NSString *msg = [response objectForKey:@"msg"];

        if (success) {
            success(@"", response);
        }
        
    } failure:^(NSError * _Nonnull error) {
        if (failure) {
            failure(error.code, error.localizedDescription);
        }
        
    }];
    
}

+ (void)GET:(NSString *)url parameters:(nullable NSDictionary *)parameters success:(nullable HHReqeustSuccess)success failure:(nullable HHRequestFailure)failure {

#ifdef DEBUG
    [HHNetworkHelper openLog];
#else
    [HHNetworkHelper closeLog];
#endif
    
    // TODO token
    NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:parameters];
//    if (YYTUserInfo.access_token) {
//        [mDic setObject:YYTUserInfo.access_token forKey:@"access_token"];
//    }
    
    [mDic setObject:@"81f58a18a77b31141f514f0bd4b2c910a7" forKey:@"access_token"];

    url = [self getCompleteUrl:url];
    
    NSLog(@"HHNetworkHelper: %@", url);
    
    [HHNetworkHelper GET:url parameters:mDic success:^(id  _Nonnull response) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

@end
