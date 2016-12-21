//
//  KCPickerTableViewController.m
//  Kapacino
//
//  Created by Igor Czarev on 4/1/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCPickerTableViewController.h"
#import "KCPickerTableViewCell.h"

@interface KCPickerTableViewController ()

@property (weak, nonatomic) IBOutlet UILabel *headerLabel;

@end

@implementation KCPickerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerLabel.text = self.categoryName;
}

- (void)viewWillLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat contentSize = self.tableView.contentSize.height;
    CGFloat tableViewHeight = self.tableView.frame.size.height;
    
    if (contentSize < tableViewHeight) {
        UIEdgeInsets contentInset = self.tableView.contentInset;
        contentInset.top = contentInset.bottom = (tableViewHeight - contentSize) / 2;
        self.tableView.contentInset = contentInset;
    }
}

//- (NSMutableDictionary *)userInfo {
//    if (!_userInfo) {
//        _userInfo = [[NSMutableDictionary alloc] init];
//    }
//    return _userInfo;
//}

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
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView reloadData];
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KCPickerTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(pickerTableViewController:didChangeUserInfo:)]) {
        [self.delegate pickerTableViewController:self didChangeUserInfo:cell.title.text];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath isEqual:tableView.indexPathForSelectedRow]) {
        return 80;
    }
    return 60;
}

@end
