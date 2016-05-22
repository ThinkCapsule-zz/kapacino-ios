//
//  KCAddItemTableViewController.h
//  Kapacino
//
//  Created by Igor Czarev on 3/22/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFClassItem.h"

@protocol KCAddItemTableViewControllerDelegate;

@interface KCAddItemTableViewController : UITableViewController

@property (nonatomic, weak) id<KCAddItemTableViewControllerDelegate> delegate;

@end

@protocol KCAddItemTableViewControllerDelegate <NSObject>

@optional

- (void)addItemTableViewController:(KCAddItemTableViewController *)controller didCreateItem:(CFClassItem *)item;

@end
