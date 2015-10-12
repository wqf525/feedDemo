//
//  CommentModel.h
//  FeedDemo
//
//  Created by 吴启飞 on 15/10/12.
//  Copyright © 2015年 吴启飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedUser.h"

@interface CommentModel : NSObject
@property (nonatomic, strong) FeedUser *commentCreater;
@property (nonatomic, strong) NSString *commentContent;
@property (nonatomic, strong) NSDate *commentCreateTime;
@end
