//
//  KCAddClassViewController.m
//  Kapacino
//
//  Created by How Else on 3/18/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCAddClassViewController.h"

#import "KCInputCell.h"

@interface KCAddClassViewController () <KCInputCellDelegate>

@property (nonatomic, strong, readwrite) CFClassModel *model;

@end

@implementation KCAddClassViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"Add Class";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveClassAction:)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[KCInputCell class] forCellReuseIdentifier:@"InputCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - Custom accessors

- (CFClassModel *)model {
    if (!_model) {
        _model = [[CFClassModel alloc] init];
    }
    return _model;
}

#pragma mark - Actions

- (void)saveClassAction:(UIBarButtonItem *)item {
    CFClassModel *model = self.model;
    
    if (!model.name.length || !model.prof.length) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(addClassViewController:didCreateClassModel:)]) {
        [self.delegate addClassViewController:self didCreateClassModel:self.model];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KCInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InputCell" forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Course";
            cell.textField.text = self.model.name;
            break;
        case 1:
            cell.textLabel.text = @"Prof";
            cell.textField.text = self.model.prof;
            break;
            
        default:
            break;
    }
    cell.delegate = self;
    
    return cell;
}

#pragma mark - Input cell delegate

- (void)inputCell:(KCInputCell *)cell didChangeTextFieldText:(NSString *)text {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    switch (indexPath.row) {
        case 0:
            self.model.name = text;
            break;
        case 1:
            self.model.prof = text;
            break;
            
        default:
            break;
    }
}

@end
