//
//  KCBenchmarkCalculatorViewController.m
//  Kapacino
//
//  Created by Igor Czarev on 3/23/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCBenchmarkCalculatorViewController.h"
#import "KCBenchmarkCaculatorTableViewController.h"

@interface KCBenchmarkCalculatorViewController ()

@property (weak, nonatomic)  KCBenchmarkCaculatorTableViewController *benchmarkTableViewController;

@end

@implementation KCBenchmarkCalculatorViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[KCBenchmarkCaculatorTableViewController class]]) {
        self.benchmarkTableViewController = segue.destinationViewController;
        self.benchmarkTableViewController.model = self.model;
    }
}

@end
