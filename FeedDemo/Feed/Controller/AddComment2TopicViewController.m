//
//  AddComment2TopicViewController.m
//  FeedDemo
//
//  Created by 吴启飞 on 15/10/12.
//  Copyright © 2015年 吴启飞. All rights reserved.
//

#import "AddComment2TopicViewController.h"
#import "AddImageCollectionViewCell.h"
#import "PhotographyHelper.h"

@interface AddComment2TopicViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UITextView *commentContentTextView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray* selectPhotos;
@property (nonatomic, strong) PhotographyHelper *photographyHelper;

@end

@implementation AddComment2TopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

-(PhotographyHelper *)photographyHelper {
    if(_photographyHelper == nil) {
        _photographyHelper = [[PhotographyHelper alloc] init];
    }
    return _photographyHelper;
}

-(NSMutableArray *)selectPhotos {
    if(_selectPhotos == nil){
        _selectPhotos = [NSMutableArray array];
    }
    return _selectPhotos;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(self.selectPhotos.count == 9) {
        return self.selectPhotos.count;
    }
    return self.selectPhotos.count +1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AddImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddImageCollectionViewCell" forIndexPath:indexPath];
    if(indexPath.row==self.selectPhotos.count) {
        cell.putupImage.image=[UIImage imageNamed:@"AlbumAddBtn"];
        cell.putupImage.highlightedImage=[UIImage imageNamed:@"AlbumAddBtnHL"];
        return cell;
    }else {
        cell.putupImage.image=self.selectPhotos[indexPath.row];
        cell.putupImage.highlightedImage=nil;
        return cell;
    }
}

static CGFloat kLZAlbumCreateVCPhotoSize = 60;
#pragma mark - Delegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kLZAlbumCreateVCPhotoSize, kLZAlbumCreateVCPhotoSize);
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)addImage:(UIImage*)image{
    [self.selectPhotos addObject:image];
    [self.collectionView reloadData];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==_selectPhotos.count){
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *actionPhoto = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.photographyHelper showOnPickerViewControllerSourceType:UIImagePickerControllerSourceTypePhotoLibrary onViewController:self completed:^(UIImage *image, NSDictionary *editingInfo) {
                if (image) {
                    [self addImage:image];
                } else {
                    if (!editingInfo)
                        return ;
                    image=[editingInfo valueForKey:UIImagePickerControllerOriginalImage];
                    if(image){
                        [self addImage:image];
                    }
                }
            }];
        }];
        UIAlertAction *actionTakePhoto = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.photographyHelper showOnPickerViewControllerSourceType:UIImagePickerControllerSourceTypeCamera onViewController:self completed:^(UIImage *image, NSDictionary *editingInfo) {
                if (image) {
                    [self addImage:image];
                } else {
                    if (!editingInfo)
                        return ;
                    image=[editingInfo valueForKey:UIImagePickerControllerOriginalImage];
                    if(image){
                        [self addImage:image];
                    }
                }
            }];
        }];
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:actionPhoto];
        [alertController addAction:actionTakePhoto];
        [alertController addAction:actionCancel];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    /**
     *  打开键盘
     */
    [self.commentContentTextView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
