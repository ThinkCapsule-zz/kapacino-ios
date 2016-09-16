//
//  KCEventDetailTableViewController.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-09-05.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "KCEventDetailTableViewController.h"
#import "CFClient.h"

@interface KCEventDetailTableViewController ()
    @property (weak, nonatomic) IBOutlet UILabel *labelType;
    @property (weak, nonatomic) IBOutlet UILabel *labelAddress;
    @property (weak, nonatomic) IBOutlet UILabel *labelPhoneNumber;
    @property (weak, nonatomic) IBOutlet UILabel *labelHours;
@end

@implementation KCEventDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self updateViews];
}

-(void) updateViews
{
    NSDateFormatter* dayFormatter = [[NSDateFormatter alloc] init];
    [dayFormatter setDateFormat: @"EEEE"];
    NSString* dayOfWeek = [dayFormatter stringFromDate:[NSDate date]];
    
//    NSDictionary* hoursDictionary = self.model.hours[dayOfWeek];
//    self.labelHours.text = [NSString stringWithFormat:@"%@ to %@",  hoursDictionary[@"start"], hoursDictionary[@"end"]];
    self.labelPhoneNumber.text = self.model.phoneNumber;
    self.labelType.text = [self.model.types componentsJoinedByString:@", "];
}

-(void) setPlace:(CFPlaceModel *)place
{
    _place = place;
    
    //Get the venue
    self.labelAddress.text = place.address;
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
