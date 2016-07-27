//
//  KCBenchmarkCalculatorViewController.h
//  Kapacino
//
//  Created by Igor Czarev on 3/23/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CFClassModel.h"

#import "KCBenchmarkLabel.h"

@interface KCBenchmarkCalculatorViewController : UIViewController

@property (strong, nonatomic) CFClassModel *model;

@property (weak, nonatomic) IBOutlet KCBenchmarkLabel *benchmarkTotalLabel;

@end
