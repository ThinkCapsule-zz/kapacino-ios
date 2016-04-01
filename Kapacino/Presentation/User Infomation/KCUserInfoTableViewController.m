//
//  KCUserInfoTableViewController.m
//  Kapacino
//
//  Created by Igor Czarev on 4/1/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCUserInfoTableViewController.h"
#import "KCUserInfoTableViewCell.h"
#import "KCPikerViewController.h"

@interface KCUserInfoTableViewController ()

@end

@implementation KCUserInfoTableViewController



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[KCUserInfoTableViewCell class]]) {
        [self prepareForSegueWithPickerController:segue.destinationViewController cell:sender];
    }
}

- (void)prepareForSegueWithPickerController:(KCPikerViewController *)controller cell:(KCUserInfoTableViewCell *)cell {
    if ([cell.title.text isEqualToString:@"Gender*"]) {
        controller.categoryName = cell.title.text;
        NSArray *items = @[ @"Female", @"Male", @"Other" ];
        controller.categoryItems = items;
    }
}

@end
