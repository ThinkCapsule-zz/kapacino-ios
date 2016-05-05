//
//  KCClassViewController.m
//  Kapacino
//
//  Created by How Else on 3/21/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCClassViewController.h"
#import "KCClassItemsTableViewController.h"
#import "KCAddItemTableViewController.h"
#import "KCBenchmarkCalculatorViewController.h"
#import "CFClassItem.h"

@interface KCClassViewController () <KCAddItemTableViewControllerDelegate>

@property (weak, nonatomic) KCClassItemsTableViewController *itemsTableViewController;
@property (weak, nonatomic) IBOutlet UILabel *totalMarkLabel;

@end

@implementation KCClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadEmptyView];
    [self updateTotalMark];
}

- (void)reloadEmptyView {
    self.emptyView.hidden = self.model.items.count > 0;
}

- (void)updateTotalMark {
    NSInteger totalMark = 0;
    for (CFClassItem *item in self.model.items) {
        totalMark += item.mark.integerValue;
    }
    self.totalMarkLabel.text = [NSString stringWithFormat:@"MARK: %ld",(long)totalMark];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[KCClassItemsTableViewController class]]) {
        [self prepareForSegueWithClassItemsTableViewController:segue.destinationViewController];
    } else if ([segue.destinationViewController isKindOfClass:[KCAddItemTableViewController class]]) {
        [self prepareForSegueWithItemTableViewController:segue.destinationViewController];
    } else if ([segue.destinationViewController isKindOfClass:[KCBenchmarkCalculatorViewController class]]) {
        [self prepareForSegueWithBenchmarkCalculatorController:segue.destinationViewController];
    }
}

- (void)prepareForSegueWithClassItemsTableViewController:(KCClassItemsTableViewController *)controller {
    controller.model = [self.model.items mutableCopy];
    self.itemsTableViewController = controller;
}

- (void)prepareForSegueWithItemTableViewController:(KCAddItemTableViewController *)controller {
    controller.delegate = self;
}

- (void)prepareForSegueWithBenchmarkCalculatorController:(KCBenchmarkCalculatorViewController *)controller {
    controller.model = self.model;
}

#pragma mark - Add item table view controller delegate

- (void)addItemTableViewController:(KCAddItemTableViewController *)controller didCreateItem:(CFClassItem *)item {
    [self.itemsTableViewController.model addObject:item];
    
    self.model.items = self.itemsTableViewController.model;
    
    [self.itemsTableViewController.tableView reloadData];
    [self reloadEmptyView];
    [self updateTotalMark];
    [self.navigationController popToViewController:self animated:YES];
}

@end
