//
//  KCPikerViewController.h
//  Kapacino
//
//  Created by Igor Czarev on 4/1/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCPickerTableViewController.h"

@protocol KCPickerViewControllerDelegate;

@interface KCPikerViewController : UIViewController

@property (strong, nonatomic) NSString *categoryName;
@property (strong, nonatomic) NSArray *categoryItems;
@property (strong, nonatomic) KCPickerTableViewController *pickerTableView;

@property (nonatomic, weak) id<KCPickerViewControllerDelegate> delegate;

@end

@protocol KCPickerViewControllerDelegate <NSObject>


@end
