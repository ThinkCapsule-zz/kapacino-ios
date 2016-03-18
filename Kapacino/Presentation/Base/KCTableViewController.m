//
//  KCTableViewController.m
//  Kapacino
//
//  Created by How Else on 3/18/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCTableViewController.h"
#import "KCTableView.h"

@implementation KCTableViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:NULL];
    }
    return self;
}

- (void)loadView {
    self.tableView = [[KCTableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

@end
