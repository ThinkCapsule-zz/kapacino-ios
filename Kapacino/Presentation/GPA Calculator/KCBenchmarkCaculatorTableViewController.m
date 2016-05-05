//
//  KCBenchmarkCaculatorTableViewController.m
//  Kapacino
//
//  Created by Igor Czarev on 3/23/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCBenchmarkCaculatorTableViewController.h"
@interface KCBenchmarkCaculatorTableViewController () <UITextFieldDelegate>

@end


@implementation KCBenchmarkCaculatorTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSInteger totalMark = 0;
    for (CFClassItem *item in self.model.items) {
        totalMark += item.mark.integerValue;
    }
    self.currentMarkTextField.text = [NSString stringWithFormat:@"%ld", (long)totalMark];
    self.dreamMarkTextField.text = self.model.dreamMark.integerValue != 0 ? self.model.dreamMark.stringValue : nil;
    self.weightTextField.text = self.model.totalWeight.integerValue != 0 ? self.model.totalWeight.stringValue : nil;
    [self updateDiagram];
}


- (IBAction)textFieldDidChange:(UITextField *)sender {
    [self updateDiagram];
}

- (void)updateDiagram {
    
    if (self.dreamMarkTextField.text.length > 0 && self.weightTextField.text.length > 0) {
        self.model.benchmark = [self calculateBenchmark];
    } else {
        self.model.benchmark = nil;
    }
    self.model.dreamMark = @(self.dreamMarkTextField.text.integerValue);
    self.model.totalWeight = @(self.weightTextField.text.integerValue);
    if ([self.delegate respondsToSelector:@selector(benchmarkCaculatorTableViewController:didChangeModel:)]) {
        [self.delegate benchmarkCaculatorTableViewController:self didChangeModel:self.model];
    }
}

- (NSNumber *)calculateBenchmark {
    NSInteger currentMark = self.currentMarkTextField.text.integerValue;
    NSInteger dreamMark = self.dreamMarkTextField.text.integerValue;
    double weight = self.weightTextField.text.doubleValue / 100;
    NSNumber *benchmark = nil;
    
    benchmark = @((dreamMark - (currentMark * weight)) / (1 - weight));
    return benchmark;
}

@end
