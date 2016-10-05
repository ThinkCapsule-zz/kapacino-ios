//
//  KCEventDetailMoreDetailTableViewController.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-09-12.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "KCEventDetailMoreDetailTableViewController.h"
#import "KCHoursTableViewController.h"

@interface KCEventDetailMoreDetailTableViewController ()
    @property (weak, nonatomic) IBOutlet UILabel *labelWebsite;
    @property (weak, nonatomic) IBOutlet UILabel *labelEmail;
    @property (weak, nonatomic) IBOutlet UILabel *labelType;
    @property (weak, nonatomic) IBOutlet UILabel *labelCrowd;
    @property (weak, nonatomic) IBOutlet UILabel *labelMusic;
    @property (weak, nonatomic) IBOutlet UILabel *labelDrinks;
    @property (weak, nonatomic) IBOutlet UILabel *labelDressCode;
@end

@implementation KCEventDetailMoreDetailTableViewController

    static NSString* kEmbedSegue = @"embedSegue";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self updateViews];
    
    //    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 45;
}

-(void) updateViews
{
//    self.labelAddress.text = self.model.address;
    self.labelWebsite.text = self.model.website;
    self.labelEmail.text = self.model.email;
    self.labelType.text = [self.model.types componentsJoinedByString:@", "];
    self.labelCrowd.text = [self.model.crowd componentsJoinedByString:@", "];
    self.labelMusic.text = [self.model.music componentsJoinedByString:@", "];
    self.labelDrinks.text = [self.model.drinks componentsJoinedByString:@", "];
    self.labelDressCode.text = [self.model.dressCode componentsJoinedByString:@", "];
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
        hoursVC.hours = self.place.hours;
    }
}

@end
