//
//  PhotographyHelper.m
//  FeedDemo
//
//  Created by 吴启飞 on 15/10/12.
//  Copyright © 2015年 吴启飞. All rights reserved.
//

#import "PhotographyHelper.h"
@interface PhotographyHelper ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, copy) DidFinishTakeMediaCompletedBlock didFinishTakeMediaCompleted;
@end
@implementation PhotographyHelper

-(instancetype)init {
    self = [super init];
    if(self) {
        
    }
    return self;
}

-(void)dealloc {
    self.didFinishTakeMediaCompleted = nil;
}

-(void)showOnPickerViewControllerSourceType:(UIImagePickerControllerSourceType)sourceType onViewController:(UIViewController *)viewController completed:(DidFinishTakeMediaCompletedBlock)completed {
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
        completed(nil, nil);
        return;
    }
    self.didFinishTakeMediaCompleted = [completed copy];
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.editing = YES;
    imagePickerController.delegate = self;
    imagePickerController.sourceType = sourceType;
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        imagePickerController.mediaTypes =  [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    [viewController presentViewController:imagePickerController animated:YES completion:NULL];
}

- (void)dismissPickerViewController:(UIImagePickerController *)picker {
    typeof(self) __weak weakSelf=self;
    [picker dismissViewControllerAnimated:YES completion:^{
        weakSelf.didFinishTakeMediaCompleted = nil;
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    if (self.didFinishTakeMediaCompleted) {
        self.didFinishTakeMediaCompleted(image, editingInfo);
    }
    [self dismissPickerViewController:picker];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    if (self.didFinishTakeMediaCompleted) {
        self.didFinishTakeMediaCompleted(nil, info);
    }
    [self dismissPickerViewController:picker];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissPickerViewController:picker];
}

@end
