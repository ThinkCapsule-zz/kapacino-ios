//
//  KCGPACalcViewController.m
//  Kapacino
//
//  Created by Alan Hsu on 2016-01-24.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCGPACalcViewController.h"
#import "KCClassViewController.h"
#import "KCAddClassViewController.h"

#import "CFClassModel.h"

#import "UINavigationController+Advanced.h"

@interface KCGPACalcViewController () <KCAddClassViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *model;

@end

@implementation KCGPACalcViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController respondsToSelector:@selector(setDelegate:)]) {
        [segue.destinationViewController setDelegate:self];
    }
}

#pragma mark - Custom accessors

- (NSMutableArray *)model {
    if (!_model) {
        _model = [[NSMutableArray alloc] init];
        
        CFClassModel *class1 = [[CFClassModel alloc] init];
        class1.name = @"ANAT 4452";
        class1.mark = @80;
        
        CFClassModel *class2 = [[CFClassModel alloc] init];
        class2.name = @"BUS 2257";
        class2.mark = @70;
        
        CFClassModel *class3 = [[CFClassModel alloc] init];
        class3.name = @"STATS 2244";
        class3.mark = @30;
        
        [_model addObjectsFromArray:@[ class1, class2, class3 ]];
    }
    return _model;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CFClassModel *model = [self.model objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassCell" forIndexPath:indexPath];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.mark.stringValue;
    
    return cell;
}

#pragma mark - Table view delegate



#pragma mark - Add class view controller delegate

- (void)addClassViewController:(KCAddClassViewController *)controller didCreateClassModel:(CFClassModel *)model {
    [self.model addObject:model];
    [self.tableView reloadData];
    
    KCClassViewController *classViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ClassViewController"];
    [self.navigationController pushViewController:classViewController fromViewController:self animated:YES];
}

@end
