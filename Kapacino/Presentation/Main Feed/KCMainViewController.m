//
//  KCMainViewController.m
//  Kapacino
//
//  Created by Alan Hsu on 2016-01-24.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCMainViewController.h"
#import "KCFeedCell.h"
#import "CFClient.h"
#import "CFModelFactory.h"
#import "KCArticleDetailViewController.h"
#import "PreflightManager.h"

@interface KCMainViewController() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *contentModels;

@end

static NSString* kCellId = @"kCellId";
static CGFloat kCellHeight = 230;


@implementation KCMainViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    /* Setup */
    self.title = @"Explore";
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"KCFeedCell" bundle:nil] forCellWithReuseIdentifier:kCellId];
    [self adjustCollectionViewForInsets];
    
    /* Fetch data */
    [self fetchContent:CFContentType_Article];

}

#pragma mark - Fetch Content

- (void)fetchContent:(CFContentType)contentType {
    
    __weak typeof(self)wSelf = self;
    
    [CFClient fetchWithContentTypeId:contentType completion:^(NSArray *responseItems, NSError *error) {
        
        wSelf.contentModels = [CFModelFactory parseResponseObjects:responseItems forType:contentType];
        [wSelf.collectionView reloadData];
        
    }];
    
}

#pragma mark - Adjust Insets

- (void)adjustCollectionViewForInsets {
    
    UIEdgeInsets adjustForTabbarInsets = UIEdgeInsetsMake(0, 0, CGRectGetHeight(self.tabBarController.tabBar.frame), 0);
    self.collectionView.contentInset = adjustForTabbarInsets;
    self.collectionView.scrollIndicatorInsets = adjustForTabbarInsets;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.contentModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KCFeedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellId forIndexPath:indexPath];
    
    [cell updateWithArticleModel:self.contentModels[indexPath.row]];
    
    return cell;
    
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KCArticleDetailViewController *articleDetailVC = [[KCArticleDetailViewController alloc] init];
    
    [articleDetailVC updateWithModel:self.contentModels[indexPath.row]];
    
    [self presentViewController:articleDetailVC animated:YES completion:nil];
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width, kCellHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

@end
