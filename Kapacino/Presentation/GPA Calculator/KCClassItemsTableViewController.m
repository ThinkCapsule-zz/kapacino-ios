//
//  KCClassItemsTableViewController.m
//  Kapacino
//
//  Created by Igor Czarev on 3/22/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCClassItemsTableViewController.h"

#import "KCClassItemTableViewCell.h"

@implementation KCClassItemsTableViewController

- (NSMutableArray *)model {
    if (!_model) {
        _model = [[NSMutableArray alloc] init];
    }
    return _model;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CFClassItem *item = [self.model objectAtIndex:indexPath.row];
    KCClassItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    cell.nameLabel.text = item.name;
    cell.markLabel.text = item.mark.stringValue;
    cell.itemDescriptionLabel.text = [NSString stringWithFormat:@"%@ | %@%@", item.type, item.weight, @"% Weight"].uppercaseString;
    return cell;
}

@end
