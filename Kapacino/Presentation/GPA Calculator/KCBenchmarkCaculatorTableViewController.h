//
//  KCBenchmarkCaculatorTableViewController.h
//  Kapacino
//
//  Created by Igor Czarev on 3/23/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CFClassModel.h"

@interface KCBenchmarkCaculatorTableViewController : UITableViewController

@property (strong, nonatomic) CFClassModel *model;

@property (weak, nonatomic) IBOutlet UITextField *currentMarkTextField;
@property (weak, nonatomic) IBOutlet UITextField *dreamMarkTextField;
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;

@end
