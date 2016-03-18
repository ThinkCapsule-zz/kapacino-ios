//
//  KCAddClassViewController.h
//  Kapacino
//
//  Created by How Else on 3/18/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCTableViewController.h"

#import "CFClassModel.h"

@protocol KCAddClassViewControllerDelegate;

@interface KCAddClassViewController : KCTableViewController

@property (nonatomic, weak) id<KCAddClassViewControllerDelegate> delegate;

@property (nonatomic, strong, readonly) CFClassModel *model;

@end

@protocol KCAddClassViewControllerDelegate <NSObject>

@optional

- (void)addClassViewController:(KCAddClassViewController *)controller didCreateClassModel:(CFClassModel *)model;

@end
