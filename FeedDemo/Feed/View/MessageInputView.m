//
//  MessageInputView.m
//  FeedDemo
//
//  Created by 吴启飞 on 15/10/12.
//  Copyright © 2015年 吴启飞. All rights reserved.
//

#import "MessageInputView.h"
#define SEND_BUTTON_WIDTH 78.0f
@interface MessageInputView(){
    BOOL _isComment;
}
-(void)setup;
-(void)setupTextView;
@end

@implementation MessageInputView

@synthesize sendButton;

-(instancetype) initWithFrame:(CGRect)frame delegate:(id<MessageInputViewDelegate>)delegate isComment:(BOOL)isComment {
    self = [super initWithFrame:frame];
    if(self) {
        _isComment = isComment;
        [self setup];
        self.delegate = delegate;
        [self setAutoresizesSubviews:NO];
    }
    return self;
}

-(void)dealloc {
    self.textView = nil;
    self.sendButton = nil;
}

-(BOOL) resignFirstResponder {
    [self.textView resignFirstResponder];
    return [self resignFirstResponder];
}

-(void)setup {
    self.image = [[UIImage imageNamed:@"input-bar"] resizableImageWithCapInsets:UIEdgeInsetsMake(19.0f, 3.0f, 19.0f, 3.0f)];
    self.backgroundColor = [UIColor whiteColor];
    self.opaque = YES;
    self.userInteractionEnabled = YES;
    UIImageView *line =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
    line.backgroundColor=[UIColor colorWithRed:188/255.0 green:188/255.0 blue:188/255.0 alpha:1.0];
    [self addSubview:line];
    self.emotionbutton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.emotionbutton setBackgroundImage:[UIImage imageNamed:@"emotion"] forState:UIControlStateNormal];
    if(_isComment)
    {
        self.emotionbutton.frame = CGRectMake(282/320.0*[UIScreen mainScreen].bounds.size.width, 9.0f, 28.0f, 28.0f);
    }
    else{
        self.emotionbutton.frame = CGRectMake(246/320.0*[UIScreen mainScreen].bounds.size.width, 9.0f, 28.0f, 28.0f);
    }
    
    [self setSendButton:self.emotionbutton];
    self.showUtilsButton  = [UIButton  buttonWithType:UIButtonTypeCustom];
    [self.showUtilsButton setBackgroundImage:[UIImage imageNamed:@"utility"] forState:UIControlStateNormal];
    self.showUtilsButton.frame=CGRectMake(282/320.0*[UIScreen mainScreen].bounds.size.width, 9.0f, 28.0f, 28.0f);
    if(!_isComment)
        [self addSubview:self.showUtilsButton];
    
    [self setupTextView];
    
    
}

- (void)setupTextView
{
    //    CGFloat width = self.frame.size.width - SEND_BUTTON_WIDTH;
    CGFloat height = [MessageInputView textViewLineHeight];
    
    self.textView = [[HPGrowingTextView  alloc] initWithFrame:CGRectMake(7.0f, 7.0f, (self.emotionbutton.frame.origin.x-15), height)];
    //    self.textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.font = [UIFont systemFontOfSize:15];
    self.textView.minHeight = 31;
    self.textView.maxNumberOfLines = 5;
    self.textView.animateHeightChange = YES;
    self.textView.animationDuration = 0.25;
    self.textView.delegate = self;
    
    [self.textView.layer setBorderWidth:0.5];
    [self.textView.layer setBorderColor:[UIColor colorWithRed:188/255.0 green:188/255.0 blue:188/255.0 alpha:1.0].CGColor];
    [self.textView.layer setCornerRadius:2];
    self.textView.returnKeyType = UIReturnKeySend;
    [self addSubview:self.textView];
}

- (BOOL)growingTextView:(HPGrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqual:@"\n"])
    {
        [self.delegate textViewEnterSend];
        return NO;
    }
    return YES;
}

- (void)setSendButton:(UIButton *)btn
{
    if(sendButton)
        [sendButton removeFromSuperview];
    
    sendButton = btn;
    [self addSubview:sendButton];
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float bottom = self.bottom;
    if ([growingTextView.text length] == 0)
    {
        [self setHeight:height + 13];
    }
    else
    {
        [self setHeight:height + 10];
    }
    [self setBottom:bottom];
    [self.delegate viewheightChanged:height];
}

- (BOOL)growingTextViewShouldReturn:(HPGrowingTextView *)growingTextView
{
    return YES;
}

+ (CGFloat)textViewLineHeight
{
    return 32.0f; // for fontSize 16.0f
}

+ (CGFloat)maxLines
{
    return 5.0f;
}

+ (CGFloat)maxHeight
{
    return ([MessageInputView maxLines] + 1.0f) * [MessageInputView textViewLineHeight];
}

- (CGFloat)bottom {
    return self.top + self.height;
}

- (void)setBottom:(CGFloat)bottom {
    if(bottom == self.bottom){
        return;
    }
    
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}
- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    if(height == self.height){
        return;
    }
    
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)top {
    return self.frame.origin.y;
}
- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

@end
