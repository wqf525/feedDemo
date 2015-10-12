//
//  FeedModel.h
//  FeedDemo
//
//  Created by 吴启飞 on 15/10/12.
//  Copyright © 2015年 吴启飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedUser.h"
@interface FeedModel : NSObject

@property (nonatomic, strong) FeedUser *creater;
@property (nonatomic, strong) NSDate *feedCreateTime;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSArray *albums;
@end
