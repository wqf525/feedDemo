//
//  CommentDetailWithCommentTableViewController.m
//  FeedDemo
//
//  Created by 吴启飞 on 15/10/12.
//  Copyright © 2015年 吴启飞. All rights reserved.
//

#import "CommentDetailWithCommentTableViewController.h"
#import "CommentTableViewCell.h"
#import "CommentHeaderFeedTableViewCell.h"

#import "MessageInputView.h"
#import "ChatUtilityViewController.h"
#import "EmotionsViewController.h"
#import "EmotionsModule.h"


typedef NS_ENUM(NSUInteger, BottomShowComponent)
{
    InputViewUp                       = 1,
    ShowKeyboard                      = 1 << 1,
    ShowEmotion                       = 1 << 2,
    ShowUtility                       = 1 << 3
};

typedef NS_ENUM(NSUInteger, BottomHiddComponent)
{
    InputViewDown                     = 14,
    HideKeyboard                      = 13,
    HideEmotion                       = 11,
    HideUtility                       = 7
};

typedef NS_ENUM(NSUInteger, PanelStatus)
{
    TextInputStatus,
    EmotionStatus,
    ImageStatus
};
#define OFFSET_Y (self.tableView.contentOffset.y+64.0)
#define NAVBAR_HEIGHT 64.f
#define SCREEN_WIDTH          [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT         [[UIScreen mainScreen] bounds].size.height
#define COMPONENT_BOTTOM          CGRectMake(0, OFFSET_Y+(SCREEN_HEIGHT - NAVBAR_HEIGHT), SCREEN_WIDTH, 216)
#define INPUT_BOTTOM_FRAME        CGRectMake(0, OFFSET_Y+(SCREEN_HEIGHT - NAVBAR_HEIGHT) - self.chatInputView.frame.size.height ,SCREEN_WIDTH,self.chatInputView.frame.size.height)
#define INPUT_HEIGHT              self.chatInputView.frame.size.height
#define INPUT_TOP_FRAME           CGRectMake(0, OFFSET_Y+(SCREEN_HEIGHT - NAVBAR_HEIGHT) - self.chatInputView.frame.size.height - 216, SCREEN_WIDTH, self.chatInputView.frame.size.height)
#define UTILITY_FRAME             CGRectMake(0, OFFSET_Y+(SCREEN_HEIGHT - NAVBAR_HEIGHT) -216, SCREEN_WIDTH, 216)
#define EMOTION_FRAME             CGRectMake(0, OFFSET_Y+(SCREEN_HEIGHT - NAVBAR_HEIGHT) -216, SCREEN_WIDTH, 216)

@interface CommentDetailWithCommentTableViewController ()<MessageInputViewDelegate,DDEmotionsViewControllerDelegate, ChatUtilityViewControllerDelegate>{
    BottomShowComponent _bottomShowComponent;
    float _inputViewY;
    NSString* _currentInputContent;
}
@property(nonatomic,strong)MessageInputView *chatInputView;
@property(nonatomic,strong)ChatUtilityViewController *utility;
@property(nonatomic,strong)EmotionsViewController *emotions;

@end

@implementation CommentDetailWithCommentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    
    [self notificationCenter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.chatInputView.textView setText:nil];
    [self hideBottomComponent];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self hideBottomComponent];
}

-(void)dealloc {
    [self removeNotification];
    if(self.chatInputView) {
        [self closeKeyBoard];
    }
}

#pragma  mark - PrivateAPI
- (void)hideBottomComponent
{
    _bottomShowComponent = _bottomShowComponent * 0;
    [self.chatInputView.textView resignFirstResponder];
    [UIView animateWithDuration:0.25 animations:^{
        self.utility.view.frame = CGRectMake(0, ([[UIScreen mainScreen] bounds].size.height - 64.0) + 64.0, [[UIScreen mainScreen] bounds].size.width, 216);;
        self.emotions.view.frame = CGRectMake(0, ([[UIScreen mainScreen] bounds].size.height - 64.0) + 64.0, [[UIScreen mainScreen] bounds].size.width, 216);;
        self.chatInputView.frame = CGRectMake(0, ([[UIScreen mainScreen] bounds].size.height - 64.0) - self.chatInputView.frame.size.height + 64.0,[[UIScreen mainScreen] bounds].size.width,self.chatInputView.frame.size.height);
        ;
    }];
    NSLog(@"%f",self.chatInputView.frame.origin.y);
    [self setValue:@(self.chatInputView.frame.origin.y) forKeyPath:@"_inputViewY"];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section ==0 )
    {
        return 1;
    }
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    if(section==0)
    {
        return 10;
    }
    else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        CommentHeaderFeedTableViewCell *cell = (CommentHeaderFeedTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CommentHeaderFeedTableViewCell" forIndexPath:indexPath];
        if(!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CommentHeaderFeedTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        FeedModel *feedModel = [FeedModel new];
        feedModel.creater = [FeedUser new];
        feedModel.creater.username = @"测试";
        feedModel.creater.avatarUrl = @"https://www.baidu.com/img/bdlogo.png";
        
        feedModel.feedCreateTime = [NSDate date];
        feedModel.content = @"百度自2014年底起，开始对部分地区开放了HTTPS加密搜索服务。直到上周，百度表示全站开启了HTTPS安全加密搜索。那么，该如何看待“百度全站采用HTTPS加密搜索”呢？ /n/r 以下为来自知乎网友雷志兴-Berg的看法： \n\r 百度在工程开发上几乎不做没有性价比的事情。所以我们先看看https这个事情在技术上的投入在哪里。我没有参与此方面任何工作，都是根据我临时推想得到，比较乱，回头";
        feedModel.albums = @[@"https://www.baidu.com/img/bdlogo.png",@"https://www.baidu.com/img/bdlogo.png",@"https://www.baidu.com/img/bdlogo.png",@"https://www.baidu.com/img/bdlogo.png",@"https://www.baidu.com/img/bdlogo.png",@"https://www.baidu.com/img/bdlogo.png",@"https://www.baidu.com/img/bdlogo.png"];
        
        [cell setFeedModel:feedModel];
        return cell;
    }else
    {
        
        CommentTableViewCell *cell = (CommentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CommentTableViewCell" forIndexPath:indexPath];
        if(!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CommentTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        CommentModel *commentModel = [CommentModel new];
        commentModel.commentCreater = [FeedUser new];
        commentModel.commentCreater.username = @"评论";
        commentModel.commentCreater.avatarUrl = @"https://www.baidu.com/img/bdlogo.png";
        commentModel.commentContent = @"百度自2014年底起，开始对部分地区开放了HTTPS加密搜索服务。直到上周，百度表示全站开启了HTTPS安全加密搜索。那么，该如何看待“百度全站采用HTTPS加密搜索”呢？ /n/r 以下为来自知乎网友雷志兴-Berg的看法： \n\r 百度在工程开发上几乎不做没有性价比的事情。所以我们先看看https这个事情在技术上的投入在哪里。我没有参与此方面任何工作，都是根据我临时推想得到，比较乱，回头";
        commentModel.commentCreateTime = [NSDate date];
        [cell setCommentModel:commentModel];
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.chatInputView) {
        [self closeKeyBoard];
    }
    else{
        [self initialInput];
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self closeKeyBoard];
}

-(void) closeKeyBoard {
    if(!self.chatInputView)
    {
        return;
    }
    [self.chatInputView.textView resignFirstResponder];
    [self.chatInputView removeFromSuperview];
    [self.emotions.view removeFromSuperview];
    /**
     *  谁申请谁释放
     */
    [self removeObserver:self forKeyPath:@"_inputViewY"];
    
    self.chatInputView = nil;
    self.emotions.view = nil;
}

#pragma mark - keyboard 相关
-(void)initialInput {
    CGFloat offsetY = self.tableView.contentOffset.y+64.0;
    CGRect inputFrame = CGRectMake(0,offsetY+ [[UIScreen mainScreen] bounds].size.height-44.0f-64.0f, [[UIScreen mainScreen] bounds].size.width, 44.0f);
    self.chatInputView = [[MessageInputView alloc] initWithFrame:inputFrame delegate:self isComment:YES];
    [self.chatInputView setBackgroundColor:[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0]];
    [self.view addSubview:self.chatInputView];
    [self.chatInputView.emotionbutton addTarget:self
                                         action:@selector(showEmotions:)
                               forControlEvents:UIControlEventTouchUpInside];
    
    [self.chatInputView.showUtilsButton addTarget:self
                                           action:@selector(showUtilitys:)
                                 forControlEvents:UIControlEventTouchDown];
    [self addObserver:self forKeyPath:@"_inputViewY" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    [self.chatInputView.textView becomeFirstResponder];
}

-(void)notificationCenter {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleWillShowKeyboard:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleWillHideKeyboard:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

-(void)removeNotification {
    [[NSNotificationCenter defaultCenter]  removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]  removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"_inputViewY"])
    {
        //            [self p_unableLoadFunction];
        [UIView animateWithDuration:0.25 animations:^{
            if (_bottomShowComponent & ShowEmotion)
            {
                CGRect frame = self.emotions.view.frame;
                frame.origin.y = self.chatInputView.bottom;
                self.emotions.view.frame = frame;
            }
            if (_bottomShowComponent & ShowUtility)
            {
                CGRect frame = self.utility.view.frame;
                frame.origin.y = self.chatInputView.bottom;
                self.utility.view.frame = frame;
            }
            
        } completion:^(BOOL finished) {
            //                [self p_enableLoadFunction];
        }];
    }
    
}

#pragma mark - MessageInputViewDelegate
- (void)viewheightChanged:(float)height
{
    [self setValue:@(self.chatInputView.frame.origin.y) forKeyPath:@"_inputViewY"];
}
- (void)textViewEnterSend
{
    NSLog(@"发送消息：%@",self.chatInputView.textView.text);
    //发送消息
    NSString* text = [self.chatInputView.textView text];
    
    NSString* parten = @"\\s";
    NSRegularExpression* reg = [NSRegularExpression regularExpressionWithPattern:parten options:NSRegularExpressionCaseInsensitive error:nil];
    NSString* checkoutText = [reg stringByReplacingMatchesInString:text options:NSMatchingReportProgress range:NSMakeRange(0, [text length]) withTemplate:@""];
    if ([checkoutText length] == 0)
    {
        return;
    }
}

#pragma mark - KeyBoardNotification
- (void)handleWillShowKeyboard:(NSNotification *)notification
{
    CGRect keyboardRect;
    keyboardRect = [(notification.userInfo)[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    _bottomShowComponent = _bottomShowComponent | ShowKeyboard;
    //什么都没有显示
    [UIView animateWithDuration:0.25 animations:^{
        [self.chatInputView setFrame:CGRectMake(0, keyboardRect.origin.y - self.chatInputView.frame.size.height, self.view.frame.size.width, self.chatInputView.frame.size.height)];
    }];
    [self setValue:@(keyboardRect.origin.y - self.chatInputView.frame.size.height) forKeyPath:@"_inputViewY"];
    
}

- (void)handleWillHideKeyboard:(NSNotification *)notification
{
    CGRect keyboardRect;
    keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    _bottomShowComponent = _bottomShowComponent & HideKeyboard;
    if (_bottomShowComponent & ShowUtility)
    {
        //显示的是插件
        [UIView animateWithDuration:0.25 animations:^{
            [self.chatInputView setFrame:INPUT_TOP_FRAME];
        }];
        [self setValue:@(self.chatInputView.frame.origin.y) forKeyPath:@"_inputViewY"];
    }
    else if (_bottomShowComponent & ShowEmotion)
    {
        //显示的是表情
        [UIView animateWithDuration:0.25 animations:^{
            [self.chatInputView setFrame:INPUT_TOP_FRAME];
        }];
        [self setValue:@(self.chatInputView.frame.origin.y) forKeyPath:@"_inputViewY"];
        
    }
    else
    {
        [self hideBottomComponent];
    }}

-(void)showEmotions:(id)sender {
    if ([_currentInputContent length] > 0)
    {
        [self.chatInputView.textView setText:_currentInputContent];
    }
    if (self.emotions == nil) {
        self.emotions = [EmotionsViewController new];
        [self.emotions.view setBackgroundColor:[UIColor darkGrayColor]];
        self.emotions.view.frame=COMPONENT_BOTTOM;
        self.emotions.delegate = self;
        [self.view addSubview:self.emotions.view];
    }
    if (_bottomShowComponent & ShowKeyboard)
    {
        //显示的是键盘,这是需要隐藏键盘，显示表情，不需要动画
        _bottomShowComponent = (_bottomShowComponent & 0) | ShowEmotion;
        [self.chatInputView.textView resignFirstResponder];
        [self.emotions.view setFrame:EMOTION_FRAME];
        [self.utility.view setFrame:COMPONENT_BOTTOM];
    }
    else if (_bottomShowComponent & ShowEmotion)
    {
        //表情面板本来就是显示的,这时需要隐藏所有底部界面
        [self.chatInputView.textView resignFirstResponder];
        _bottomShowComponent = _bottomShowComponent & HideEmotion;
    }
    else if (_bottomShowComponent & ShowUtility)
    {
        //显示的是插件，这时需要隐藏插件，显示表情
        [self.utility.view setFrame:COMPONENT_BOTTOM];
        [self.emotions.view setFrame:EMOTION_FRAME];
        _bottomShowComponent = (_bottomShowComponent & HideUtility) | ShowEmotion;
    }
    else
    {
        //这是什么都没有显示，需用动画显示表情
        _bottomShowComponent = _bottomShowComponent | ShowEmotion;
        [UIView animateWithDuration:0.25 animations:^{
            [self.emotions.view setFrame:EMOTION_FRAME];
            [self.chatInputView setFrame:INPUT_TOP_FRAME];
        }];
        [self setValue:@(INPUT_TOP_FRAME.origin.y) forKeyPath:@"_inputViewY"];
    }
}

-(void)showUtilitys:(id)sender {
    if ([_currentInputContent length] > 0)
    {
        [self.chatInputView.textView setText:_currentInputContent];
    }
    
    if (self.utility == nil)
    {
        self.utility = [ChatUtilityViewController new];
        self.utility.delegate = self;
        [self addChildViewController:self.utility];
        self.utility.view.frame=CGRectMake(0, self.view.frame.size.height,self.view.frame.size.width , 280);
        [self.view addSubview:self.utility.view];
    }
    
    if (_bottomShowComponent & ShowKeyboard)
    {
        //显示的是键盘,这是需要隐藏键盘，显示插件，不需要动画
        _bottomShowComponent = (_bottomShowComponent & 0) | ShowUtility;
        [self.chatInputView.textView resignFirstResponder];
        [self.utility.view setFrame:UTILITY_FRAME];
        [self.emotions.view setFrame:COMPONENT_BOTTOM];
    }
    else if (_bottomShowComponent & ShowUtility)
    {
        //插件面板本来就是显示的,这时需要隐藏所有底部界面
        //        [self p_hideBottomComponent];
        [self.chatInputView.textView becomeFirstResponder];
        _bottomShowComponent = _bottomShowComponent & HideUtility;
    }
    else if (_bottomShowComponent & ShowEmotion)
    {
        //显示的是表情，这时需要隐藏表情，显示插件
        [self.emotions.view setFrame:COMPONENT_BOTTOM];
        [self.utility.view setFrame:UTILITY_FRAME];
        _bottomShowComponent = (_bottomShowComponent & HideEmotion) | ShowUtility;
    }
    else
    {
        //这是什么都没有显示，需用动画显示插件
        _bottomShowComponent = _bottomShowComponent | ShowUtility;
        [UIView animateWithDuration:0.25 animations:^{
            [self.utility.view setFrame:UTILITY_FRAME];
            [self.chatInputView setFrame:INPUT_TOP_FRAME];
        }];
        [self setValue:@(INPUT_TOP_FRAME.origin.y) forKeyPath:@"_inputViewY"];
        
    }
    
}

#pragma mark - EmotionsViewController Delegate
- (void)emotionViewClickSendButton
{
    [self textViewEnterSend];
}
-(void)insertEmojiFace:(NSString *)string
{
    NSMutableString* content = [NSMutableString stringWithString:self.chatInputView.textView.text];
    [content appendString:string];
    [self.chatInputView.textView setText:content];
}
-(void)deleteEmojiFace
{
    EmotionsModule* emotionModule = [EmotionsModule shareInstance];
    NSString* toDeleteString = nil;
    if (self.chatInputView.textView.text.length == 0)
    {
        return;
    }
    if (self.chatInputView.textView.text.length == 1)
    {
        self.chatInputView.textView.text = @"";
    }
    else
    {
        toDeleteString = [self.chatInputView.textView.text substringFromIndex:self.chatInputView.textView.text.length - 1];
        int length = [emotionModule.emotionLength[toDeleteString] intValue];
        if (length == 0)
        {
            toDeleteString = [self.chatInputView.textView.text substringFromIndex:self.chatInputView.textView.text.length - 2];
            length = [emotionModule.emotionLength[toDeleteString] intValue];
        }
        length = length == 0 ? 1 : length;
        self.chatInputView.textView.text = [self.chatInputView.textView.text substringToIndex:self.chatInputView.textView.text.length - length];
    }
    
}

@end
