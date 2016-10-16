//
//  KCUserInfoTableViewController.h
//  Kapacino
//
//  Created by Igor Czarev on 4/1/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCPickerTableViewController.h"
#import "KCUserInfoTableViewCell.h"
#import "KCSearchViewController.h"
#import "User.h"

@interface KCUserInfoTableViewController : UITableViewController <KCSearchViewControllerDelegate, UITextFieldDelegate, KCPickerTableViewControllerDelegate>

@property (strong, nonatomic) User *user;

- (void)prepareForSegueWithPickerController:(KCPickerTableViewController *)controller cell:(KCUserInfoTableViewCell *)cell;

@end
