//
//  PhotographyHelper.h
//  FeedDemo
//
//  Created by 吴启飞 on 15/10/12.
//  Copyright © 2015年 吴启飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^DidFinishTakeMediaCompletedBlock)(UIImage *image,NSDictionary *eiditingInfo);
@interface PhotographyHelper : NSObject
-(void)showOnPickerViewControllerSourceType:(UIImagePickerControllerSourceType)sourceType onViewController:(UIViewController *)viewController completed:(DidFinishTakeMediaCompletedBlock)completed;
@end
