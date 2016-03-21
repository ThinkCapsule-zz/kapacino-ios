//
//  KCAddClassViewController.m
//  Kapacino
//
//  Created by How Else on 3/18/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCAddClassViewController.h"

@interface KCAddClassViewController ()

@property (nonatomic, strong, readwrite) CFClassModel *model;

@end

@implementation KCAddClassViewController

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

- (IBAction)doneAction:(UIBarButtonItem *)item {
    CFClassModel *model = self.model;
    
    if (!model.name.length || !model.prof.length) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(addClassViewController:didCreateClassModel:)]) {
        [self.delegate addClassViewController:self didCreateClassModel:self.model];
    }
}

- (IBAction)courseTextFieldEditingChanged:(UITextField *)textField {
    self.model.name = textField.text;
}

- (IBAction)profTextFieldEditingChanged:(UITextField *)textField {
    self.model.prof = textField.text;
}

@end
