//
//  KCRestaurantDetailMoreDetailTableViewController.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-09-12.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "KCRestaurantDetailMoreDetailTableViewController.h"
#import "KCHoursTableViewController.h"

@interface KCRestaurantDetailMoreDetailTableViewController ()
    @property (weak, nonatomic) IBOutlet UILabel *labelWebsite;
    @property (weak, nonatomic) IBOutlet UILabel *labelCuisine;
    @property (weak, nonatomic) IBOutlet UILabel *labelOnCampus;
    @property (weak, nonatomic) IBOutlet UILabel *labelStudentCard;
    @property (weak, nonatomic) IBOutlet UILabel *labelCreditCard;
    @property (weak, nonatomic) IBOutlet UILabel *labelDelivery;

@end

@implementation KCRestaurantDetailMoreDetailTableViewController

    static NSString* kEmbedSegue = @"embedSegue";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self updateViews];
    
    self.tableView.estimatedRowHeight = 45;
}

-(void) updateViews
{
    self.labelWebsite.text = self.model.website;
    self.labelCuisine.text = self.model.type;
    self.labelOnCampus.text = self.model.isOnCampus ? @"YES" : @"NO";
    self.labelStudentCard.text = self.model.isStudentCardAccepted > 0 ? @"YES" : @"NO";
    self.labelCreditCard.text = self.model.creditCardsAccepted.count ? @"YES" : @"NO";
    self.labelDelivery.text = self.model.isDeliveryAccepted ? @"YES" : @"NO";
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:kEmbedSegue])
    {
        KCHoursTableViewController* hoursVC = segue.destinationViewController;
        hoursVC.hours = self.model.hours;
    }
}

@end
