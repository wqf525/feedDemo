//
//  FeedTopicTableViewCell.m
//  FeedDemo
//
//  Created by 吴启飞 on 15/10/12.
//  Copyright © 2015年 吴启飞. All rights reserved.
//

#import "FeedTopicTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <DateTools/DateTools.h>

@interface FeedTopicTableViewCell() {
    TopicModel *__topicModel;
}
@end

@implementation FeedTopicTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setTopicModel:(TopicModel *)topicModel {
    __topicModel = topicModel;
    [self.topicAvatarImage sd_setImageWithURL:[NSURL URLWithString:__topicModel.topicCreater.avatarUrl] placeholderImage:[UIImage imageNamed:@"avator"]];
    self.topicUsernameLabel.text = __topicModel.topicCreater.username;
    self.topicTimeLabel.text = [__topicModel.topicCreateTime formattedDateWithFormat:@"MM-dd HH:mm"];
    self.topicContentLabel.text = __topicModel.topicContent;
    [self.contentView setNeedsUpdateConstraints];
}

@end
