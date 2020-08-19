//
//  ChatRequestV2.m
//  HHChatKit
//
//  Created by Henry on 2020/8/19.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "ChatRequestV2.h"
#import "HHInterfacedHeader.h"
#import "HHRequest.h"

@implementation ChatRequestV2

/// dgtype;
// 会话组类型 0-医医交流 1-会诊交流 2-协作会诊(Consultationinfor ciapplytype = 1)
// 3-医患交流(DoctorAndPatientInfor) 6-培训交流 7-科组交流 8-课程会议直播 9-会议课程附属直播
+ (void)createGroup:(NSString *)dgtype users:(NSArray *)users dgmrecordid:(NSString *)dgmrecordid completion:(void (^)(BOOL, NSDictionary * _Nonnull))completion {
    
    NSDictionary *params = @{ @"dgtype": dgtype,
                              @"users": [users componentsJoinedByString:@","],
                              @"dgmrecordid": dgmrecordid
    };
    
    [HHRequest POST:kCreateGroupApi parameters:params success:^(NSString * _Nonnull msg, id  _Nonnull response) {
        
    } failure:^(NSInteger code, NSString * _Nonnull msg) {
        
    }];
}

+ (void)updateGroup:(NSString *)dgid dgname:(NSString *)dgname dgmrecordid:(NSString *)dgmrecordid completion:(void (^)(BOOL, NSDictionary * _Nonnull))completion {
    
    NSDictionary *params = @{ @"dgid":dgid ?: @"",
                              @"dgname":dgname ?: @"",
                              @"dgmrecordid":dgmrecordid ?: @""
    };
    
    [HHRequest POST:kUpdateGroupApi parameters:params success:^(NSString * _Nonnull msg, id  _Nonnull response) {
        
    } failure:^(NSInteger code, NSString * _Nonnull msg) {
        
    }];

}

+ (void)addMembersGroup:(NSString *)dgid users:(NSArray *)users completion:(void (^)(BOOL, NSDictionary * _Nonnull))completion {
    NSDictionary *params = @{ @"dgid": dgid,
                              @"users": [users componentsJoinedByString:@","] };
    [HHRequest POST:kAddMembersGroupApi parameters:params success:^(NSString * _Nonnull msg, id  _Nonnull response) {
        
    } failure:^(NSInteger code, NSString * _Nonnull msg) {
        
    }];

}

/// 删除会话成员
+ (void)deleteMembersGroup:(NSString *)dgid users:(NSArray *)users completion:(void(^)(BOOL success, NSDictionary *info))completion {
    NSDictionary *params = @{ @"dgid": dgid,
                              @"users": [users componentsJoinedByString:@","] };
    [HHRequest POST:kDeleteMembersGroupApi parameters:params success:^(NSString * _Nonnull msg, id  _Nonnull response) {
        
    } failure:^(NSInteger code, NSString * _Nonnull msg) {
        
    }];
    
}

/// 会话列表
+ (void)listGroup:(NSString *)type completion:(void(^)(BOOL success, NSDictionary *info))completion {
    NSDictionary *params = @{ @"eacgtype":type?:@"" };
    [HHRequest POST:kListGroupApi parameters:params success:^(NSString * _Nonnull msg, id  _Nonnull response) {
        
    } failure:^(NSInteger code, NSString * _Nonnull msg) {
        
    }];
}

@end
