//
//  CommentHeaderFeedTableViewCell.h
//  FeedDemo
//
//  Created by 吴启飞 on 15/10/12.
//  Copyright © 2015年 吴启飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedModel.h"

@interface CommentHeaderFeedTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *feedAvatarImage;
@property (weak, nonatomic) IBOutlet UILabel *feedUserNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *feedCreateTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *feedContent;
@property (weak, nonatomic) IBOutlet UICollectionView *feedAlbumCollection;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (nonatomic, strong) FeedModel *feedModel;
@end
