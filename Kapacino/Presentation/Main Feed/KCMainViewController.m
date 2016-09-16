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
#import "PreflightManager.h"
#import <INSPullToRefresh/UIScrollView+INSPullToRefresh.h>
#import <INSPullToRefresh/INSDefaultPullToRefresh.h>

@interface KCMainViewController() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, INSPullToRefreshBackgroundViewDelegate>    
@end

static NSString* kCellId = @"kCellId";
static CGFloat kCellRatio = 4.0f/3.0f;


@implementation KCMainViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title_image"]];
    titleImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = titleImageView;
    
    /* Setup */
    self.title = @"Main";
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"KCFeedCell" bundle:nil] forCellWithReuseIdentifier:kCellId];
    [self adjustCollectionViewForInsets];
    
    [self setupPullToRefresh];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /* Fetch data */
    [self fetchContent];
}

-(void) setContentType:(CFContentType)contentType
{
    _contentType = contentType;
    [self fetchContent];
}

#pragma mark - Private
- (void)setupPullToRefresh {
    
    __weak typeof(self)wSelf = self;
    [self.collectionView ins_addPullToRefreshWithHeight:60.0 handler:^(UIScrollView *scrollView) {
        [wSelf.collectionView ins_endPullToRefresh];
        [wSelf fetchContent];
    }];
    
    CGRect defaultFrame = CGRectMake(0, 0, 24, 24);
    
    UIView <INSPullToRefreshBackgroundViewDelegate> *pullToRefresh = [[INSDefaultPullToRefresh alloc] initWithFrame:defaultFrame backImage:[UIImage imageNamed:@"circleLight"] frontImage:[UIImage imageNamed:@"circleDark"]];
    
    self.collectionView.ins_pullToRefreshBackgroundView.delegate = pullToRefresh;
    [self.collectionView.ins_pullToRefreshBackgroundView addSubview:pullToRefresh];
}

#pragma mark - Fetch Content

- (void)fetchContent {
    
    if (self.collectionView != nil)
    {
        __weak typeof(self)wSelf = self;
        
        CFContentType contentType = [wSelf contentType];
        
        [CFClient fetchWithContentTypeId:contentType completion:^(NSArray *responseItems, NSError *error) {
            
            wSelf.contentModels = [CFModelFactory parseResponseObjects:responseItems forType:contentType];
            [wSelf.collectionView reloadData];
            
        }];
    }
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
    
//    [cell updateWithArticleModel:self.contentModels[indexPath.row]];
    [self updateCell:cell forContentModel:self.contentModels[indexPath.row] atRow:indexPath.row];
    
    return cell;
    
}

-(void) updateCell:(KCFeedCell*) cell forContentModel:(NSObject*) contentModel atRow:(NSInteger) row
{
    
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.width / kCellRatio);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (void)pullToRefreshBackgroundView:(INSPullToRefreshBackgroundView *)pullToRefreshBackgroundView didChangeState:(INSPullToRefreshBackgroundViewState)state {
    
}

- (void)pullToRefreshBackgroundView:(INSPullToRefreshBackgroundView *)pullToRefreshBackgroundView didChangeTriggerStateProgress:(CGFloat)progress {
    //
}

@end
