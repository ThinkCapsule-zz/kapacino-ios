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
#import "KCPickerTableViewController.h"

@interface KCUserInfoTableViewController () <KCPickerTableViewControllerDelegate>

@end

@implementation KCUserInfoTableViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.userInfo = [NSMutableDictionary dictionaryWithDictionary:@{ @"Country" : @"Canada", @"Gender" : @"Female"}];
}

- (NSMutableDictionary *)userInfo {
    if (!_userInfo) {
        _userInfo =  [[NSMutableDictionary alloc] init];
    }
    return _userInfo;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[KCUserInfoTableViewCell class]]) {
        [self prepareForSegueWithPickerController:segue.destinationViewController cell:sender];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(KCUserInfoTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [cell.title.text substringToIndex:cell.title.text.length - 1];
    NSString *subTitleString = [self.userInfo objectForKey:key];
    if (subTitleString) {
        cell.subTitle.text = subTitleString;
    }
}

- (void)prepareForSegueWithPickerController:(KCPikerViewController *)controller cell:(KCUserInfoTableViewCell *)cell {
    controller.delegate = self;
    controller.categoryName = cell.title.text;
    if ([cell.title.text isEqualToString:@"Gender*"]) {
        NSArray *items = @[ @"Female", @"Male", @"Other" ];
        controller.categoryItems = items;
    } else if ([cell.title.text isEqualToString:@"Country*"]) {
        NSArray *items = @[ @"USA", @"Canada", @"UK" ];
        controller.categoryItems = items;
    } else if ([cell.title.text isEqualToString:@"Hometown*"]) {
        NSArray *items = @[ @"New-York", @"Toronto", @"London", @"L.A.", @"Ottava", @"Liverpool" ];
        controller.categoryItems = items;
    }
}

- (void)pickerTableViewController:(KCPickerTableViewController *)controller didSelectValue:(NSString *)value forKey:(NSString *)key {
    key = [key substringToIndex:key.length - 1];
    [self.userInfo setValue:value forKey:key];
    KCUserInfoTableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.tableView.indexPathForSelectedRow];
    cell.subTitle.text = value;
}

@end
