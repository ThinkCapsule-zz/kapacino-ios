//
//  KCTableView.m
//  Kapacino
//
//  Created by How Else on 3/18/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCTableView.h"

@implementation KCTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layoutMargins = UIEdgeInsetsZero;
        self.separatorInset = UIEdgeInsetsZero;
        self.tableFooterView = [[UIView alloc] init];
    }
    return self;
}

@end
