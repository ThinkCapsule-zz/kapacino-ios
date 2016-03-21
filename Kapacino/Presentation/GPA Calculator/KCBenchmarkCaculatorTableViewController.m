//
//  KCBenchmarkCaculatorTableViewController.m
//  Kapacino
//
//  Created by Igor Czarev on 3/23/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCBenchmarkCaculatorTableViewController.h"

@implementation KCBenchmarkCaculatorTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CFClassItem *item = self.model.items.firstObject;
    self.currentMarkTextField.text = item.mark.stringValue;
    self.weightTextField.text = item.weight.stringValue;
    self.dreamMarkTextField.text = @"75";
}

@end
