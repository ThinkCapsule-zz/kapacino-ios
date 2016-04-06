//
//  KCUserInfoTableViewController.m
//  Kapacino
//
//  Created by Igor Czarev on 4/1/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCUserInfoTableViewController.h"
#import "KCSearchViewController.h"

@interface KCUserInfoTableViewController ()

@end

@implementation KCUserInfoTableViewController

-(void)viewDidLoad {
    [super viewDidLoad];
}

- (NSMutableDictionary *)userInfo {
    if (!_userInfo) {
        _userInfo =  [[NSMutableDictionary alloc] init];
    }
    return _userInfo;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[KCUserInfoTableViewCell class]] && [segue.destinationViewController isKindOfClass:[KCPickerTableViewController class]]) {
        [self prepareForSegueWithPickerController:segue.destinationViewController cell:sender];
    } else if ([sender isKindOfClass:[KCUserInfoTableViewCell class]] && [segue.destinationViewController isKindOfClass:[KCSearchViewController class]]) {
        [self prepareForSegueWithSearchViewController:segue.destinationViewController cell:sender];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(KCUserInfoTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [cell.title.text substringToIndex:cell.title.text.length - 1];
    NSString *subTitleString = [self.userInfo objectForKey:key];
    if (subTitleString) {
        cell.subTitle.text = subTitleString;
    }
}

- (void)prepareForSegueWithPickerController:(KCPickerTableViewController *)controller cell:(KCUserInfoTableViewCell *)cell {
    controller.delegate = self;
    controller.userInfo = self.userInfo;
    controller.categoryName = cell.title.text;
    if ([cell.title.text isEqualToString:@"Gender*"]) {
        NSArray *items = @[ @"Female", @"Male", @"Other" ];
        controller.items = items;
    } else if ([cell.title.text isEqualToString:@"Country*"]) {
        NSArray *items = @[ @"USA", @"Canada", @"UK" ];
        controller.items = items;
    } else if ([cell.title.text isEqualToString:@"Hometown*"]) {
        NSArray *items = @[ @"New-York", @"Toronto", @"London", @"L.A.", @"Ottava", @"Liverpool" ];
        controller.items = items;
    }
}

- (void)prepareForSegueWithSearchViewController:(KCSearchViewController *)controller cell:(KCUserInfoTableViewCell *)cell {
    controller.delegate = self;
    controller.categoryName = cell.title.text;
    controller.userInfo = self.userInfo;
}

- (IBAction)nameTextFieldEditingChanged:(UITextField *)sender {
    [self.userInfo setObject:sender.text forKey:@"Name"];
}

- (void)pickerTableViewController:(KCPickerTableViewController *)controller didChangeUserInfo:(NSMutableDictionary *)userInfo {
    _userInfo = userInfo;
    [self.tableView reloadData];
}

- (void)searchViewController:(KCSearchViewController *)controller didChangeUserInfo:(NSMutableDictionary *)userInfo {
    _userInfo = userInfo;
    [self.tableView reloadData];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}

@end
