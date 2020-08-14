//
//  HHMessagesViewController.m
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHMessagesViewController.h"
#import "HHKeyBoardView.h"
#import "UIView+HHKeyBoard.h"
#import "UIScrollView+HHKeyBoard.h"
#import "HHKeyBoardHeader.h"
#import "HHChatManager.h"
#import "UIColor+HHKeyBoard.h"
#import "NSString+HHKeyBoard.h"

#import "HHTextMessageCell.h"
#import "HHImageMessageCell.h"
#import "HHVoiceMessageCell.h"
#import "HHSystemMessageCell.h"

#import "HHHeader.h"
#import "HHMessage.h"

#import "HHMessageDataProviderService.h"
#import "ToastTool.h"


@interface HHMessagesViewController () <UITableViewDataSource, UITableViewDelegate, HHKeyBoardViewDelegate, HHMessageCellDelegate, HHMessageListener>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HHKeyBoardView *keyBoardView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *heightCache;

@property (nonatomic, strong) HHMessageCellData *menuUIMsg;

@property (nonatomic, strong) NSMutableArray<HHKeyBoardMoreItem *> *moreItems;

@end

@implementation HHMessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.keyBoardView];
    
    [self.tableView registerClass:[HHTextMessageCell class] forCellReuseIdentifier:TextMessageCell_ReuseId];
    [self.tableView registerClass:[HHImageMessageCell class] forCellReuseIdentifier:ImageMessageCell_ReuseId];
    [self.tableView registerClass:[HHVoiceMessageCell class] forCellReuseIdentifier:VoiceMessageCell_ReuseId];
    [self.tableView registerClass:[HHSystemMessageCell class] forCellReuseIdentifier:SystemMessageCell_ReuseId];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapViewController)];
    [self.tableView addGestureRecognizer:tap];
    
    [[HHChatManager shareManager] setMessageListener:self];
}

- (void)didTapViewController {
    [self.keyBoardView dismissKeyboard];
}

#pragma mark - HHMessageListener

- (void)onNewMessage:(NSArray *)msgs {
    for (HHMessage *msg in msgs) {
        for (int i = 0; i < msg.elemCount; i ++) {
            HHElem *elem = [msg getElem:i];
            HHMessageCellData *data = [HHMessageDataProviderService getMessageCellDataWithElem:elem message:msg];
            
            [self.dataSource addObject:data];
            [self.tableView reloadData];
            [self scrollToBottom:YES];
        }
    }
}

#pragma mark - 发送
- (void)sendMessage:(HHMessageCellData *)msg {
    
    HHMessage *imMsg = msg.innerMessage;
    
    if (imMsg) {
        // 重发 移除原来的
        NSInteger row = [self.dataSource indexOfObject:msg];
        [self.heightCache removeObjectAtIndex:row];
        [self.dataSource removeObjectAtIndex:row];
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    // 添加HHMessage
    msg.innerMessage = [HHMessageDataProviderService getMessage:msg];

    // 添加到列表
    [self.dataSource addObject:msg];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.dataSource.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    [self scrollToBottom:YES];

    // 发送
    if (msg.innerMessage) {
        [[HHChatManager shareManager] sendMessage:msg.innerMessage cb:nil];
    }

}

- (void)sendText:(NSString *)text {
    text = text.trim;
    if (text.length == 0) {
        NSLog(@"发送文字为空");
        return;
    }
        
    [self sendMessage:[HHMessageDataProviderService getMessageCellData:text]];
}

- (void)sendVoice:(NSDictionary *)voice {
    [self sendMessage:[HHMessageDataProviderService getMessageCellDataWithVoice:voice]];
}

#pragma mark - Public Method

- (void)repleceMoreItems:(NSMutableArray<HHKeyBoardMoreItem *> *)items {
    self.moreItems = items;
    if (self.keyBoardView && items.count > 0) {
        [self.keyBoardView setMoreItems:items];
    }
}

- (void)addMoreItem:(HHKeyBoardMoreItem *)item {
    [self.moreItems addObject:item];
    [self.keyBoardView setMoreItems:self.moreItems];
}

- (void)onActionPhoto {
    
}

- (void)onAcitonCamera {
    
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHMessageCellData *data = self.dataSource[indexPath.row];
    HHMessageCell *cell = nil;

    if (!data.reuseId) {
        if ([data isKindOfClass:[HHTextMessageCellData class]]) {
            data.reuseId = TextMessageCell_ReuseId;
        } else if ([data isKindOfClass:[HHImageMessageCellData class]]) {
            data.reuseId = ImageMessageCell_ReuseId;
        } else if ([data isKindOfClass:[HHVoiceMessageCellData class]]) {
            data.reuseId = VoiceMessageCell_ReuseId;
        } else if ([data isKindOfClass:[HHSystemMessageCellData class]]) {
            data.reuseId = SystemMessageCell_ReuseId;
        } else {
            return nil;
        }
    }
    
    cell = [tableView dequeueReusableCellWithIdentifier:data.reuseId forIndexPath:indexPath];
    cell.delegate = self;
    [cell fillWithData:self.dataSource[indexPath.row]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    if(_heightCache.count > indexPath.row){
        return [_heightCache[indexPath.row] floatValue];
    }
    HHMessageCellData *data = self.dataSource[indexPath.row];
    height = [data heightOfWidth:kbScreenWidth];
    [_heightCache insertObject:[NSNumber numberWithFloat:height] atIndex:indexPath.row];
    return height;
}

#pragma mark - HHKeyBoardViewDelegate

- (void)keyboard:(HHKeyBoardView *)keyboard didSelectedMoreItem:(HHKeyBoardMoreItem *)moreItem {
    switch (moreItem.type) {
        case HHKeyboardMoreItemTypePhoto:
        {
            [self onActionPhoto];
        }
            break;
        case HHKeyboardMoreItemTypeCamera:
        {
            [self onAcitonCamera];
        }
            break;
            
        default:
            break;
    }
}

- (void)keyboard:(HHKeyBoardView *)keyboard sendText:(NSString *)text {
    [self sendText:text];
}

- (void)keyboard:(HHKeyBoardView *)keyboard sendVoice:(NSDictionary *)voice {
    if (!voice) {
        return;
    }
    int duration = [voice[@"duration"] intValue];
    NSString *path = voice[@"path"];
    if (!path || duration < 1) {
        [ToastTool show:@"说话时间太短"];
        return;
    }
    
    // TODO 上传语音文件，发送语音
    
    [self sendVoice:voice];
    
}

- (void)onErr:(int)errCode errMsg:(NSString *)errMsg {
    NSLog(@"onErr: %@", errMsg);
}

- (void)keyboard:(HHKeyBoardView *)keyboard didChangeTextViewHeight:(CGFloat)height {
    
}

- (void)keyboard:(HHKeyBoardView *)keyboard height:(CGFloat)height {
    // TODO 包含了 Height_SafeBottom
    [self updateTableViewInsets:height-kbHeightSafeBottom];
    [self scrollToBottom:YES];
}

- (void)updateTableViewInsets:(CGFloat)bottom {
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0.0f, bottom, 0.0f);
    self.tableView.contentInset = insets;
    self.tableView.scrollIndicatorInsets = insets;
}

- (void)scrollToBottom:(BOOL)animate {
    if (self.dataSource.count > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataSource.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:animate];
        });
    }
}

#pragma mark - HHMessageCellDelegate

- (void)onSelectMessageAvatar:(HHMessageCell *)cell {

}

- (void)onSelectMessage:(HHMessageCell *)cell {
    
}

- (void)onRetryMessage:(HHMessageCell *)cell {
    
}

- (void)onLongPressMessage:(HHMessageCell *)cell {
    NSMutableArray *items = [NSMutableArray array];
    HHMessageCellData *data = cell.messageData;

    if ([data isKindOfClass:[HHTextMessageCellData class]]) {
        [items addObject:[[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(onCopyMsg:)]];
    }
    
    BOOL isFirstResponder = NO;
    
    if (isFirstResponder) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuDidHide:) name:UIMenuControllerDidHideMenuNotification object:nil];
    } else {
        [self becomeFirstResponder];
    }
    UIMenuController *controller = [UIMenuController sharedMenuController];
    controller.menuItems = items;
    _menuUIMsg = data;
    [controller setTargetRect:cell.container.bounds inView:cell.container];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [controller setMenuVisible:YES animated:YES];
    });
    
}

- (void)menuDidHide:(NSNotification*)notification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerDidHideMenuNotification object:nil];
}

#pragma mark ---

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(onDelete:) ||
        action == @selector(onReSend:) ||
        action == @selector(onCopyMsg:) ||
        action == @selector(onRevoke:) ) {
        return YES;
    }
    return NO;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark - Memu Action

- (void)onCopyMsg:(id)sender {
    if ([_menuUIMsg isKindOfClass:[HHTextMessageCellData class]]) {
        HHTextMessageCellData *txtMsg = (HHTextMessageCellData *)_menuUIMsg;
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = txtMsg.content;
    }
}

- (void)onDelete:(id)sender {}

- (void)onReSend:(id)sender {
}

- (void)onRevoke:(id)sender {
}

#pragma mark - Getters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-55-kbHeightSafeBottom) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.backgroundColor = [UIColor hh_colorWithString:@"#f4f4f4"];
//        _tableView.showsVerticalScrollIndicator = NO;
//        _tableView.showsHorizontalScrollIndicator = NO;
        
    }
    return _tableView;
}

- (HHKeyBoardView *)keyBoardView {
    if (!_keyBoardView) {
        _keyBoardView = [[HHKeyBoardView alloc] init];
        _keyBoardView.delegate = self;
        _keyBoardView.frame = CGRectMake(0, self.view.frame.size.height-55-kbHeightSafeBottom, self.view.frame.size.width, 55);
        // TODO 待完成 表情
        _keyBoardView.showFace = NO;
        [_keyBoardView setMoreItems:self.moreItems];
        
    }
    return _keyBoardView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)heightCache {
    if (!_heightCache) {
        _heightCache = [NSMutableArray array];
    }
    return _heightCache;
}

//  屏幕将要旋转
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    NSLog(@"viewWillTransitionToSize");
    
    if (size.width > size.height) { // 横屏
        // 横屏布局
    } else {
        // 竖屏布局
    }
    
    self.tableView.frame = CGRectMake(0, 0, size.width, size.height-55-kbHeightSafeBottom);
    self.keyBoardView.frame = CGRectMake(0, size.height-55-kbHeightSafeBottom, size.width, 55);

}

- (NSMutableArray<HHKeyBoardMoreItem *> *)moreItems {
    if (!_moreItems) {
        _moreItems = [NSMutableArray array];
        HHKeyBoardMoreItem *item1 = [HHKeyBoardMoreItem moreItemWithType:HHKeyboardMoreItemTypePhoto title:@"图片" imagePath:@"chat_more_icons_photo"];
        HHKeyBoardMoreItem *item2 = [HHKeyBoardMoreItem moreItemWithType:HHKeyboardMoreItemTypeCamera title:@"拍摄" imagePath:@"chat_more_icons_camera"];
        [_moreItems addObject:item1];
        [_moreItems addObject:item2];
    }
    return _moreItems;
}

@end
