//
//  KCPickerTableViewController.m
//  Kapacino
//
//  Created by Igor Czarev on 4/1/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCPickerTableViewController.h"
#import "KCPickerTableViewCell.h"
#import "UIColor+KCAdditions.h"

@interface KCPickerTableViewController ()

@property (strong, nonatomic) NSIndexPath *selectedRowIndexPath;

@end

@implementation KCPickerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KCPickerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pickerCell" forIndexPath:indexPath];
    cell.title.text = [self.items objectAtIndex:indexPath.row];
    if (indexPath != self.selectedRowIndexPath) {
        cell.backgroundColor = [UIColor whiteColor];
        cell.title .textColor = [UIColor lightGrayColor];
        cell.titleLeftConstaint.constant = 50;
    } else {
        cell.backgroundColor = [UIColor kc_ApplicationColor];
        cell.title .textColor = [UIColor whiteColor];
        cell.titleLeftConstaint.constant = 15;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KCPickerTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(pickerTableViewController:didSelectValue:)]) {
        [self.delegate pickerTableViewController:self didSelectValue:cell.title.text];
    }
    self.selectedRowIndexPath = indexPath;
    [tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath == self.selectedRowIndexPath) {
        return 80;
    }
    return 60;
}

@end
