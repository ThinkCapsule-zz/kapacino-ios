//
//  HoursTableViewController.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-09-12.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "KCHoursTableViewController.h"

@interface KCHoursTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelHoursMonday;
@property (weak, nonatomic) IBOutlet UILabel *labelHoursTuesday;
@property (weak, nonatomic) IBOutlet UILabel *labelHoursWednesday;
@property (weak, nonatomic) IBOutlet UILabel *labelHoursThursday;
@property (weak, nonatomic) IBOutlet UILabel *labelHoursFriday;
@property (weak, nonatomic) IBOutlet UILabel *labelHoursSaturday;
@property (weak, nonatomic) IBOutlet UILabel *labelHoursSunday;
@end

@implementation KCHoursTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.labelHoursMonday.text = [self generateString:@"Monday"];
    self.labelHoursTuesday.text = [self generateString:@"Tuesday"];
    self.labelHoursWednesday.text = [self generateString:@"Wednesday"];
    self.labelHoursThursday.text = [self generateString:@"Thursday"];
    self.labelHoursFriday.text = [self generateString:@"Friday"];
    self.labelHoursSaturday.text = [self generateString:@"Saturday"];
    self.labelHoursSunday.text = [self generateString:@"Sunday"];
}
                                                       
-(NSString*) generateString:(NSString*) dayOfWeek
{
    NSString* start = self.hours[dayOfWeek][@"start"];
    NSString* end = self.hours[dayOfWeek][@"end"];
    
    return [NSString stringWithFormat:@"%@ - %@", start, end];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
