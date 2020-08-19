//
//  HHMessagesViewController.m
//  HHChatKit
//
//  Created by Henry on 2020/8/13.
//  Copyright © 2020 Henry. All rights reserved.
//

#import "HHMessagesViewController.h"
#import "HHKeyBoardView.h"
#import "HHKeyBoardHeader.h"
#import "HHChatManager.h"

#import "UIView+HHLayout.h"
#import "UIScrollView+HHKeyBoard.h"
#import "UIColor+HHKeyBoard.h"
#import "NSString+HHKeyBoard.h"
#import "NSDate+HHChat.h"

#import "HHHeader.h"
#import "HHHelper.h"

#import "HHMessage.h"

#import "HHImageCache.h"
#import "HHMessageDataProviderService.h"
#import "ToastTool.h"
#import "ImageTool.h"
#import "AlertTool.h"
#import "HHAudioPlayer.h"

@interface HHMessagesViewController () <UITableViewDataSource, UITableViewDelegate, HHKeyBoardViewDelegate, HHMessageCellDelegate, HHMessageListener>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HHKeyBoardView *keyBoardView;

@property (nonatomic, strong) NSMutableArray *uiMsgs;
@property (nonatomic, strong) NSMutableArray *heightCache;

@property (nonatomic, strong) HHMessageCellData *menuUIMsg;
@property (nonatomic, strong) HHMessageCellData *reSendUIMsg;

@property (nonatomic, strong) NSMutableArray<HHKeyBoardMoreItem *> *moreItems;

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, assign) BOOL isScrollBottom;
@property (nonatomic, assign) BOOL isLoadingMsg;
@property (nonatomic, assign) BOOL noMoreMsg;
@property (nonatomic, assign) BOOL firstLoad;

@end

@implementation HHMessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[HHChatManager shareManager] setMessageListener:self];
    
    [self setupViews];
    [self loadMessage];
}

- (void)didTapViewController {
    [self.keyBoardView dismissKeyboard];
}

- (void)setupViews {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.keyBoardView];
    
    [self.tableView registerClass:[HHTextMessageCell class] forCellReuseIdentifier:TextMessageCell_ReuseId];
    [self.tableView registerClass:[HHImageMessageCell class] forCellReuseIdentifier:ImageMessageCell_ReuseId];
    [self.tableView registerClass:[HHVoiceMessageCell class] forCellReuseIdentifier:VoiceMessageCell_ReuseId];
    [self.tableView registerClass:[HHSystemMessageCell class] forCellReuseIdentifier:SystemMessageCell_ReuseId];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapViewController)];
    [self.tableView addGestureRecognizer:tap];
        
    _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, TMessageController_Header_Height)];
    _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.tableView.tableHeaderView = _indicatorView;
       
    _heightCache = [NSMutableArray array];
    _uiMsgs = [NSMutableArray array];
    _firstLoad = YES;
    
}

- (void)loadMessage {
    if (_isLoadingMsg || _noMoreMsg) {
        return;
    }
    _isLoadingMsg = YES;
    int msgCount = MessageCount;
    
    @weakify(self)
    [self loadMessageWithComplation:^(BOOL status, NSArray *msgs) {
        @strongify(self)
        
        if (msgs != 0) {
            self.msgForGet = msgs[0];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
                   
            if (msgs.count < msgCount) {
                self.noMoreMsg = YES;
                self.indicatorView.mm_h = 0;
            }
            
            if (msgs.count != 0) {
                NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, msgs.count)];
                [self.uiMsgs insertObjects:msgs atIndexes:indexSet];
                [self.heightCache removeAllObjects];
                [self.tableView reloadData];
                [self.tableView layoutIfNeeded];

                if (!self.firstLoad) {
                    CGFloat visibleHeight = 0;
                    for (NSInteger i = 0; i < msgs.count; ++i) {
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                        visibleHeight += [self tableView:self.tableView heightForRowAtIndexPath:indexPath];
                    }
                    visibleHeight -= self.tableView.contentInset.bottom;
                    if (self.noMoreMsg) {
                        visibleHeight -= TMessageController_Header_Height;
                    }
                    [self.tableView scrollRectToVisible:CGRectMake(0, self.tableView.contentOffset.y + visibleHeight, self.tableView.frame.size.width, self.tableView.frame.size.height) animated:NO];
                }
            }
            
            self.isLoadingMsg = NO;
            [self.indicatorView stopAnimating];
            self.firstLoad = NO;
                        
        });
        
    }];

}

- (void)loadMessageWithComplation:(void(^)(BOOL status, NSArray *msgs))complation {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 20; i ++) {
        HHTextMessageCellData *cell = [[HHTextMessageCellData alloc] initWithDirection:(i%2==0)?MsgDirectionIncoming:MsgDirectionOutgoing];
        cell.name = [NSString stringWithFormat:@"name %d", i];
        cell.content = [NSString stringWithFormat:@"content %d", i];
        cell.showName = cell.direction==MsgDirectionIncoming;
        cell.showTime = YES;
        [arr addObject:cell];
    }
    if (complation) {
        complation(YES, arr);
    }
}

- (BOOL)showTimeFrom:(NSString *)time {

    if (!_msgForDate) {
        return YES;
    }
    
    NSDate *date = [NSDate dateForTimestamp:time];
    NSDate *msgDate = [NSDate dateForTimestamp:_msgForDate.time];
    
    if (fabs([date timeIntervalSinceDate:msgDate]) > (5 * 60)) {
        return YES;
    }
    
    return NO;
}

#pragma mark - HHMessageListener

- (void)onNewMessage:(NSArray *)msgs {
    for (HHMessage *msg in msgs) {
        for (int i = 0; i < msg.elemCount; i ++) {
            TIMElem *elem = [msg getElem:i];
            HHMessageCellData *data = [HHMessageDataProviderService getMessageCellDataWithElem:elem message:msg];
            data.showName = YES;
            
            BOOL showTime = [self showTimeFrom:[msg timestamp]];
            if (showTime) {
                _msgForDate = data;
            }
            data.showTime = showTime;
            
            // 头像 名称
            data.avatarUrl = [NSURL URLWithString:[HHHelper randAvatarUrl]];
            
            [_uiMsgs addObject:data];
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
        NSInteger row = [_uiMsgs indexOfObject:msg];
        [_heightCache removeObjectAtIndex:row];
        [_uiMsgs removeObjectAtIndex:row];
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    // 添加HHMessage
    msg.innerMessage = [HHMessageDataProviderService getMessage:msg];
    // 发送中
    msg.status = Msg_Status_Sending;
    
    // 添加到列表
    [_uiMsgs addObject:msg];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_uiMsgs.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    [self scrollToBottom:YES];

    __weak typeof(self) ws = self;

    // 发送
    if (msg.innerMessage) {
        [[HHChatManager shareManager] sendMessage:msg.innerMessage succ:^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [ws changeMsg:msg status:Msg_Status_Succ];
            });
            
        } fail:^(int code, NSString * _Nonnull desc) {
            
            NSLog(@"====== code: %d msg: %@" , code, desc);
            dispatch_async(dispatch_get_main_queue(), ^{
                [ws changeMsg:msg status:Msg_Status_Fail];
            });
            
        }];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (msg.status == Msg_Status_Sending) {
            [ws changeMsg:msg status:Msg_Status_Sending];
        }
    });

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

- (void)sendImage:(UIImage *)image {
    if (!image) {
        [ToastTool showAtCenter:@"请选择有效的图片"];
        return;
    }

    // 发送图片
    [self sendMessage:[HHMessageDataProviderService getMessageCellDataWithImage:image]];

}

- (void)changeMsg:(HHMessageCellData *)msg status:(HHMsgStatus)status {
    msg.status = status;
    NSInteger index = [_uiMsgs indexOfObject:msg];
    HHMessageCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [cell fillWithData:msg];
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
    [ImageTool imagePickerMultipleWithController:self count:9 completion:^(NSArray<UIImage *> * _Nonnull images) {
        for (UIImage *image in images) {
            [self sendImage:image];
        }
    }];
}

- (void)onAcitonCamera {
    [ImageTool cameraWithController:self completion:^(UIImage * _Nonnull image) {
        
    }];
//    NSArray *arr = @[@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1597480175&di=2d466c58f048d3b8393913597561eaae&src=http://a3.att.hudong.com/14/75/01300000164186121366756803686.jpg"];
//    [ImageTool showImageWithController:self source:arr index:0];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isScrollBottom == NO) {
        [self scrollToBottom:NO];
        if (indexPath.row == _uiMsgs.count-1) {
            _isScrollBottom = YES;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _uiMsgs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HHMessageCellData *data = _uiMsgs[indexPath.row];
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
    [cell fillWithData:_uiMsgs[indexPath.row]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    if(_heightCache.count > indexPath.row){
        return [_heightCache[indexPath.row] floatValue];
    }
    HHMessageCellData *data = _uiMsgs[indexPath.row];
    height = [data heightOfWidth:kbScreenWidth];
    [_heightCache insertObject:[NSNumber numberWithFloat:height] atIndex:indexPath.row];
    return height;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!_noMoreMsg && scrollView.contentOffset.y <= TMessageController_Header_Height) {
        if (!_indicatorView.isAnimating) {
            [_indicatorView startAnimating];
        }
    } else {
        if (_indicatorView.isAnimating) {
            [_indicatorView stopAnimating];
        }
    }

//    NSLog(@"%f", scrollView.contentOffset.y);
    // TODO 为了点击状态栏到顶部  self.navigationController.navigationBar.translucent 有关系
    
    if (self.navigationController.navigationBar.translucent) {
        if (scrollView.contentOffset.y == -kbHeightNavBar) {
            [self loadMessage];
        }
    } else {
        if (scrollView.contentOffset.y == 0) {
            [self loadMessage];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y <= TMessageController_Header_Height) {
        [self loadMessage];
    }
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
    if (_uiMsgs.count > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.uiMsgs.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:animate];
        });
    }
}

#pragma mark - HHMessageCellDelegate

- (void)onSelectMessageAvatar:(HHMessageCell *)cell {

}

- (void)onSelectMessage:(HHMessageCell *)cell {
    [self didTapViewController];
    if ([cell isKindOfClass:[HHImageMessageCell class]]) {
        [self showImageMessage:(HHImageMessageCell *)cell];
        
    } else if ([cell isKindOfClass:[HHVoiceMessageCell class]]) {
        [self playVoiceMessage:(HHVoiceMessageCell *)cell];
        
    }
}

- (void)onRetryMessage:(HHMessageCell *)cell {
    _reSendUIMsg = cell.messageData;
    [AlertTool alertWithTitle:@"确定重发此消息吗？" message:nil cancelTitle:@"取消" buttonTitles:@[@"重发"] actionsBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
        if (buttonIndex == 0) {
            [self sendMessage:self.reSendUIMsg];
        }
    }];
}

- (void)onLongPressMessage:(HHMessageCell *)cell {
    NSMutableArray *items = [NSMutableArray array];
    HHMessageCellData *data = cell.messageData;

    if ([data isKindOfClass:[HHTextMessageCellData class]]) {
        [items addObject:[[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(onCopyMsg:)]];
    }
    
    // TOOD 撤回 自己的消息5分钟 或者管理员3天
    long long interval = [[NSDate timestamp:[NSDate date]] longLongValue] - [data.time longLongValue];
    if (data.direction == MsgDirectionOutgoing) {
        // 发送
        [items addObject:[[UIMenuItem alloc] initWithTitle:@"撤回" action:@selector(onRevoke:)]];
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

#pragma mark - 点击Messagecell

/// 图片
- (void)showImageMessage:(HHImageMessageCell *)cell {
    [ImageTool showImageWithController:self source:@[cell.imageData.thumbImage] index:0];
}

/// 播放语音
- (void)playVoiceMessage:(HHVoiceMessageCell *)cell {
    // 离线语音已读上报

    // 播放语音
    
    if (cell.voiceData.voiceStatus == HHVoiceMessageStatusNormal) {
        // 播放语音消息
        cell.voiceData.voiceStatus = HHVoiceMessageStatusPlaying;
        [cell playVoiceMessage];
        [[HHAudioPlayer sharedAudioPlayer] playAudioAtPath:cell.voiceData.path complete:^(BOOL finished) {
            cell.voiceData.voiceStatus = HHVoiceMessageStatusNormal;
            [cell stopVoiceMessage];
        }];
    } else {
        [[HHAudioPlayer sharedAudioPlayer] stopPlayingAudio];
        [cell stopVoiceMessage];
    }
    
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
    if (!_menuUIMsg) {
        return;
    }
    NSUInteger index = [_uiMsgs indexOfObject:_menuUIMsg];
    if (index == NSNotFound) {
        return;
    }
    
    [_uiMsgs removeObject:_menuUIMsg];
    
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];

    HHSystemMessageCellData *data = [[HHSystemMessageCellData alloc] initWithDirection:_menuUIMsg.direction];
    data.content = [NSString stringWithFormat:@"%@撤回一条消息", _menuUIMsg.name];
    data.time = _menuUIMsg.time;
    
    [_uiMsgs insertObject:data atIndex:index];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
//    [self scrollToBottom:YES];
    
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
        HHKeyBoardMoreItem *item1 = [HHKeyBoardMoreItem moreItemWithType:HHKeyboardMoreItemTypePhoto title:@"图片" image:[[HHImageCache sharedInstance] getImageFromMessageCache:@"chat_more_icons_photo"]];
        HHKeyBoardMoreItem *item2 = [HHKeyBoardMoreItem moreItemWithType:HHKeyboardMoreItemTypeCamera title:@"拍摄" image:[[HHImageCache sharedInstance] getImageFromMessageCache:@"chat_more_icons_camera"]];
        [_moreItems addObject:item1];
        [_moreItems addObject:item2];
    }
    return _moreItems;
}

@end
