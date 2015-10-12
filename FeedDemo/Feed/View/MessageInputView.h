//
//  MessageInputView.h
//  FeedDemo
//
//  Created by 吴启飞 on 15/10/12.
//  Copyright © 2015年 吴启飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HPGrowingTextView/HPGrowingTextView.h>

@protocol  MessageInputViewDelegate <NSObject>

- (void)viewheightChanged:(float)height;
- (void)textViewEnterSend;

@end

@interface MessageInputView : UIImageView<HPGrowingTextViewDelegate>
@property (nonatomic, strong) HPGrowingTextView *textView;
@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) UIButton *showUtilsButton;
@property (nonatomic, strong) UIButton *emotionbutton;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, weak) id<MessageInputViewDelegate> delegate;
-(instancetype) initWithFrame:(CGRect)frame delegate:(id<MessageInputViewDelegate>)delegate isComment:(BOOL)isComment;


+(CGFloat)textViewLineHeight;
+(CGFloat)maxLines;
+(CGFloat)maxHeight;
@end
