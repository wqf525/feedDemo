//
//  CommentTableViewCell.h
//  FeedDemo
//
//  Created by 吴启飞 on 15/10/12.
//  Copyright © 2015年 吴启飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

@interface CommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *commentAvatarImage;
@property (weak, nonatomic) IBOutlet UILabel *commentUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentContentLabel;


@property (nonatomic, strong) CommentModel *commentModel;
@end
