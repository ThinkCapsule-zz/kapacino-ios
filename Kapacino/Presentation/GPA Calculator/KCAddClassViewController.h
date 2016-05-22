//
//  KCAddClassViewController.h
//  Kapacino
//
//  Created by How Else on 3/18/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CFClassModel.h"

@protocol KCAddClassViewControllerDelegate;

@interface KCAddClassViewController : UITableViewController

@property (nonatomic, weak) id<KCAddClassViewControllerDelegate> delegate;

@property (nonatomic, strong, readonly) CFClassModel *model;

@property (nonatomic, weak) IBOutlet UITextField *courseTextField;
@property (nonatomic, weak) IBOutlet UITextField *profTextField;

@end

@protocol KCAddClassViewControllerDelegate <NSObject>

@optional

- (void)addClassViewController:(KCAddClassViewController *)controller didCreateClassModel:(CFClassModel *)model;

@end
