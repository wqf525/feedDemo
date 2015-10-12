//
//  CommentHeaderFeedTableViewCell.m
//  FeedDemo
//
//  Created by 吴启飞 on 15/10/12.
//  Copyright © 2015年 吴启飞. All rights reserved.
//

#import "CommentHeaderFeedTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <DateTools/DateTools.h>
#import "FeedAlbumCollectionViewCell.h"
#import <MWPhotoBrowser/MWPhotoBrowser.h>

@interface CommentHeaderFeedTableViewCell()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,MWPhotoBrowserDelegate> {
    FeedModel *__feedModel;
    NSMutableArray *_photoUrlArray;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionHeight;

@end

@implementation CommentHeaderFeedTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.feedAlbumCollection.delegate = self;
    self.feedAlbumCollection.dataSource = self;
}

-(void) setFeedModel:(FeedModel *)feedModel {
    __feedModel = feedModel;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat itemWidth = (screenWidth-8*4)/3.0;
    if(__feedModel.albums && __feedModel.albums.count>0)
    {
        NSInteger item1 = (ceil(__feedModel.albums.count/3.0));
        NSInteger item2 = item1 *itemWidth;
        NSInteger item3 = item2 + 8*(item1-1);
        self.collectionHeight.constant = item3;
        if(!_photoUrlArray) {
            _photoUrlArray = [NSMutableArray array];
        }else {
            [_photoUrlArray removeAllObjects];
        }
        for (int i=0; i<__feedModel.albums.count; i++) {
            [_photoUrlArray addObject:[MWPhoto photoWithURL:[NSURL URLWithString:__feedModel.albums[i]]]];
        }
        
    }else
    {
        self.collectionHeight.constant = 0;
    }
    [self.feedAvatarImage sd_setImageWithURL:[NSURL URLWithString:__feedModel.creater.avatarUrl] placeholderImage:[UIImage imageNamed:@"avator"]];
    self.feedUserNameLabel.text = __feedModel.creater.username;
    self.feedCreateTimeLabel.text = [__feedModel.feedCreateTime formattedDateWithFormat:@"MM-dd HH:mm"];
    self.feedContent.text = __feedModel.content;
    
    [self.feedAlbumCollection reloadData];
    
    [self.contentView setNeedsUpdateConstraints];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat itemWidth = (screenWidth-8*4)/3.0;
    return CGSizeMake(itemWidth, itemWidth);
}


#pragma -mark UICollectionViewDataSource 
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return __feedModel.albums.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FeedAlbumCollectionViewCell *cell = (FeedAlbumCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"FeedAlbumCollectionViewCell" forIndexPath:indexPath];
    [cell.feedAlbumImage sd_setImageWithURL:[NSURL URLWithString:__feedModel.albums[indexPath.row]] placeholderImage:[UIImage imageNamed:@"avator"]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    // Set options
    browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    browser.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    browser.autoPlayOnAppear = NO; // Auto-play first vide
    
    [browser setCurrentPhotoIndex:indexPath.row];
    UIViewController* myVC = [self myViewController];
    if(myVC) {
        [myVC.navigationController pushViewController:browser animated:YES];
    }
    
    
    // Manipulate
    [browser showNextPhotoAnimated:YES];
    [browser showPreviousPhotoAnimated:YES];
}

- (UIViewController *)myViewController {
    // Traverse responder chain. Return first found view controller, which will be
    // the view's view controller.
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass:[UIViewController class]])
            return (UIViewController *)responder;
    // If the view controller isn't found, return nil.
    return nil;
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photoUrlArray.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if(index <_photoUrlArray.count) {
        return [_photoUrlArray objectAtIndex:index];
    }
    return nil;
}
@end
