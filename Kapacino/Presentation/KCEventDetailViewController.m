//
//  KCEventDetailViewController.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-09-12.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "KCEventDetailViewController.h"

@interface KCEventDetailViewController ()
    @property (weak, nonatomic) IBOutlet UIImageView *imageViewBackground;
    @property (weak, nonatomic) IBOutlet UILabel *labelName;
    @property (weak, nonatomic) IBOutlet UILabel *labelAddressAndTime;
    @property (weak, nonatomic) IBOutlet UIView *viewInfo;
    @property (weak, nonatomic) IBOutlet UICollectionView *collectionViewImages;
    @property (weak, nonatomic) IBOutlet UIView *constraintContainerViewHeight;
    @property (weak, nonatomic) IBOutlet UICollectionView *constraintCollectionViewHeight;
    @property (weak, nonatomic) IBOutlet UITextView *labelDescription;

    @property (weak, nonatomic) IBOutlet UILabel *labelVenueName;
    @property (weak, nonatomic) IBOutlet UITextView *labelVenueDescription;
@end

@implementation KCEventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
