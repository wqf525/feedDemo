//
//  CommentTableViewCell.m
//  FeedDemo
//
//  Created by 吴启飞 on 15/10/12.
//  Copyright © 2015年 吴启飞. All rights reserved.
//

#import "CommentTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <DateTools.h>

@interface CommentTableViewCell() {
    CommentModel *__commentModel;
}

@end
@implementation CommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCommentModel:(CommentModel *)commentModel {
    __commentModel = commentModel;
    [self.commentAvatarImage sd_setImageWithURL:[NSURL URLWithString:__commentModel.commentCreater.avatarUrl] placeholderImage:[UIImage imageNamed:@"avator"]];
    self.commentUsernameLabel.text = __commentModel.commentCreater.username;
    self.commentTimeLabel.text = [__commentModel.commentCreateTime formattedDateWithFormat:@"MM-dd HH:mm"];
    self.commentContentLabel.text = __commentModel.commentContent;
    [self.contentView setNeedsUpdateConstraints];
}

@end
