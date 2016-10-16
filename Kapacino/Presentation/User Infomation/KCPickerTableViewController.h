//
//  KCPickerTableViewController.h
//  Kapacino
//
//  Created by Igor Czarev on 4/1/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h";

@protocol KCPickerTableViewControllerDelegate;

@interface KCPickerTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) NSString *categoryName;
@property (strong, nonatomic) User *user;

@property (nonatomic, weak) id<KCPickerTableViewControllerDelegate> delegate;

@end

@protocol KCPickerTableViewControllerDelegate <NSObject>

@optional

- (void)pickerTableViewController:(KCPickerTableViewController *)controller didChangeUserInfo:(NSMutableDictionary *)userInfo;

@end

