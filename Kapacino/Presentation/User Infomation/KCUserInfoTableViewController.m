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

@property (weak, nonatomic) IBOutlet UILabel *headerLabel;

@end

@implementation KCUserInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *userName = self.user.name;
    if (userName) {
        NSString *firstName = [[userName componentsSeparatedByString:@" "] firstObject];
        self.headerLabel.text = [NSString stringWithFormat:@"Hey, %@",firstName ];
        self.headerLabel.adjustsFontSizeToFitWidth = YES;
        self.headerLabel.minimumScaleFactor = 0.5;
    } else {
        self.headerLabel.text = @"Hello";
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[KCUserInfoTableViewCell class]] && [segue.destinationViewController isKindOfClass:[KCPickerTableViewController class]]) {
        [self prepareForSegueWithPickerController:segue.destinationViewController cell:sender];
    } else if ([sender isKindOfClass:[KCUserInfoTableViewCell class]] && [segue.destinationViewController isKindOfClass:[KCSearchViewController class]]) {
        [self prepareForSegueWithSearchViewController:segue.destinationViewController cell:sender];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(KCUserInfoTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([cell.title.text isEqualToString:@"Name*"]) {
//        cell.subTitle.text = self.user.name;
//    } else
    if ([cell.title.text isEqualToString:@"University*"]) {
        //TODO Get university from id
        cell.subTitle.text = self.user.userInfo.schoolId;
    } else if ([cell.title.text isEqualToString:@"Major*"]) {
        cell.subTitle.text = self.user.userInfo.major;
    } else if ([cell.title.text isEqualToString:@"Minor*"]) {
        cell.subTitle.text = self.user.userInfo.minor;
    } else if ([cell.title.text isEqualToString:@"Year of Study*"]) {
        cell.subTitle.text = self.user.userInfo.yearOfStudy;
    }
}

- (void)prepareForSegueWithPickerController:(KCPickerTableViewController *)controller cell:(KCUserInfoTableViewCell *)cell {
    controller.delegate = self;
    controller.categoryName = cell.title.text;
    
    if ([cell.title.text isEqualToString:@"Major*"]) {
        NSArray *items = @[ @"USA", @"Canada", @"UK" ];
        controller.items = items;
    } else if ([cell.title.text isEqualToString:@"Minor*"]) {
        NSArray *items = @[ @"New-York", @"Toronto", @"London", @"L.A.", @"Ottava", @"Liverpool" ];
        controller.items = items;
    } else if ([cell.title.text isEqualToString:@"Year of Study*"]) {
        NSArray *items = @[ @"Freshman (First Year)", @"Sophomore (Second Year)", @"Senior (Third Year)", @"Senior (Fourth Year)" ];
        controller.items = items;
    }
    
//    if ([cell.title.text isEqualToString:@"Gender*"]) {
//        NSArray *items = @[ @"Female", @"Male", @"Other" ];
//        controller.items = items;
//    } else if ([cell.title.text isEqualToString:@"Country*"]) {
//        NSArray *items = @[ @"USA", @"Canada", @"UK" ];
//        controller.items = items;
//    } else if ([cell.title.text isEqualToString:@"Hometown*"]) {
//        NSArray *items = @[ @"New-York", @"Toronto", @"London", @"L.A.", @"Ottava", @"Liverpool" ];
//        controller.items = items;
//    }
}

- (void)prepareForSegueWithSearchViewController:(KCSearchViewController *)controller cell:(KCUserInfoTableViewCell *)cell {
    controller.delegate = self;
    controller.categoryName = cell.title.text;
}
//
//- (IBAction)nameTextFieldEditingChanged:(UITextField *)sender {
////    [self.userInfo setObject:sender.text forKey:@"Name"];
//}

- (void)pickerTableViewController:(KCPickerTableViewController *)controller didChangeUserInfo:(NSString *) info {

    if ([controller.categoryName isEqualToString:@"Major*"])
    {
        self.user.userInfo.major = info;
    }
    else if ([controller.categoryName isEqualToString:@"Minor*"])
    {
        self.user.userInfo.minor = info;
    }
    else if ([controller.categoryName isEqualToString:@"Year of Study*"])
    {
        self.user.userInfo.yearOfStudy = info;
    }
    
    [self.tableView reloadData];
}

- (void)searchViewController:(KCSearchViewController *)controller didChangeUserInfo:(NSString *) info {
    if ([controller.categoryName isEqualToString:@"University*"])
    {
        self.user.userInfo.schoolId = info;
    }
    
    [self.tableView reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}

@end
