//
//  KCRestaurantViewController.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-09-03.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "KCRestaurantDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CFClient.h"
#import "KCImageCell.h"

@interface KCRestaurantDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBackground;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelAddressAndTime;
@property (weak, nonatomic) IBOutlet UIView *viewInfo;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewImages;
@property (weak, nonatomic) IBOutlet UIView *constraintContainerViewHeight;
@property (weak, nonatomic) IBOutlet UICollectionView *constraintCollectionViewHeight;
@property (weak, nonatomic) IBOutlet UITextView *labelDescription;
@end

@implementation KCRestaurantDetailViewController

static NSString* kCellIdentifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.labelName.text = self.model.name;
//    self.labelAddressAndTime.text = self.model.address;
    self.labelDescription.text = self.model.descriptionText;
    
    [CFClient fetchAssetWithId:self.model.backgroundImageId completion:^(NSURL *imageURL, NSError *error) {
        [self.imageViewBackground sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"image_placeholder"]];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.model.thumbnailIds.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KCImageCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    cell.imageId = self.model.thumbnailIds[indexPath.item];
    
    return cell;
}

#pragma mark - CollectionViewLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float width = floor(collectionView.bounds.size.width/3);
    return CGSizeMake(width, width);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
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

