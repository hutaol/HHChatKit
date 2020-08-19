//
//  HHInterfacedHeader.h
//  HHChatKit
//
//  Created by Henry on 2020/8/19.
//  Copyright © 2020 Henry. All rights reserved.
//

#ifndef HHInterfacedHeader_h
#define HHInterfacedHeader_h

/// 创建会话
static NSString *kCreateGroupApi = @"/v2/api/group/create";
/// 更新会话
static NSString *kUpdateGroupApi = @"/v2/api/group/update";
/// 添加成员
static NSString *kAddMembersGroupApi = @"/v2/api/group/addmembers";
/// 踢出会话成员
static NSString *kDeleteMembersGroupApi = @"/v2/api/group/deletemembers";
/// 会话列表
static NSString *kListGroupApi = @"/v2/api/group/list";


#endif /* HHInterfacedHeader_h */
