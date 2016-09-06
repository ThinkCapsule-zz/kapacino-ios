//
//  KCRestaurantDetailTableViewController.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-09-05.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "KCRestaurantDetailTableViewController.h"

@interface KCRestaurantDetailTableViewController ()
    @property (weak, nonatomic) IBOutlet UILabel *labelHours;
@end

@implementation KCRestaurantDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSString* dayOfWeek = @"Monday";
    self.labelHours.text = self.model.hours[dayOfWeek];
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
