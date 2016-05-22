//
//  KCClassItemsTableViewController.h
//  Kapacino
//
//  Created by Igor Czarev on 3/22/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CFClassItem.h"

@protocol KCClassItemsTableViewControllerDelegate;

@interface KCClassItemsTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *model;
@property (nonatomic, weak) id<KCClassItemsTableViewControllerDelegate> delegate;

@end

@protocol KCClassItemsTableViewControllerDelegate <NSObject>

@optional

- (void)classItemsTableViewController:(KCClassItemsTableViewController *)controller didRemoveItem:(CFClassItem *)item;

@end