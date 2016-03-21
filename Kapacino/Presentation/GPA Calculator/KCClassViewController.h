//
//  KCClassViewController.h
//  Kapacino
//
//  Created by How Else on 3/21/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CFClassModel.h"

@interface KCClassViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *emptyView;

@property (strong, nonatomic)  CFClassModel *model;

@end
