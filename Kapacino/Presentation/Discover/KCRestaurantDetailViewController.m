//
//  KCRestaurantViewController.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-09-03.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "KCRestaurantDetailViewController.h"

@interface KCRestaurantDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelAddressAndTime;
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
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
//    cell.image =
    return cell;
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

