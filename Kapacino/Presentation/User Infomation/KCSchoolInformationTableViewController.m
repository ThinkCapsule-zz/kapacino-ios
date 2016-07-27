//
//  KCSchoolInformationTableViewController.m
//  Kapacino
//
//  Created by Igor Czarev on 4/5/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCSchoolInformationTableViewController.h"

@implementation KCSchoolInformationTableViewController

- (void)prepareForSegueWithPickerController:(KCPickerTableViewController *)controller cell:(KCUserInfoTableViewCell *)cell {
    [super prepareForSegueWithPickerController:controller cell:cell];
    if ([cell.title.text isEqualToString:@"Country of school*"]) {
        NSArray *items = @[ @"USA", @"Canada", @"UK" ];;
        controller.items = items;
    } else if ([cell.title.text isEqualToString:@"School*"]) {
        NSArray *items = @[ @"School of Public Service", @"Western Canada High School", @"Canada School of Public Service" ];
        controller.items = items;
    } else if ([cell.title.text isEqualToString:@"Major*"]) {
        NSArray *items = @[ @"New-York", @"Toronto", @"London", @"L.A.", @"Ottava", @"Liverpool", @"New-York", @"Toronto", @"London", @"L.A.", @"Ottava", @"Liverpool" ];
        controller.items = items;
    } else if ([cell.title.text isEqualToString:@"I'm currently a(n)*"]) {
        NSArray *items = @[ @"New-York", @"Toronto", @"London", @"L.A.", @"Ottava", @"Liverpool" ];
        controller.items = items;
    }
}

@end
