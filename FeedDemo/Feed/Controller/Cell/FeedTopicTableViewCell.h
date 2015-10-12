//
//  FeedTopicTableViewCell.h
//  FeedDemo
//
//  Created by 吴启飞 on 15/10/12.
//  Copyright © 2015年 吴启飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicModel.h"

@interface FeedTopicTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *topicAvatarImage;
@property (weak, nonatomic) IBOutlet UILabel *topicUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *topicTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *topicContentLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (nonatomic, strong) TopicModel *topicModel;
@end
