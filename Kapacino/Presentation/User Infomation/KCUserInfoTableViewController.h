//
//  KCUserInfoTableViewController.h
//  Kapacino
//
//  Created by Igor Czarev on 4/1/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCPikerViewController.h"
#import "KCPickerTableViewController.h"
#import "KCUserInfoTableViewCell.h"
#import "KCSearchViewController.h"

@interface KCUserInfoTableViewController : UITableViewController <KCPickerViewControllerDelegate, KCSearchViewControllerDelegate>

@property (strong, nonatomic) NSMutableDictionary *userInfo;

- (void)prepareForSegueWithPickerController:(KCPikerViewController *)controller cell:(KCUserInfoTableViewCell *)cell;

@end
