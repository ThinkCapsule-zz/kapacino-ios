//
//  KCAddItemTableViewController.m
//  Kapacino
//
//  Created by Igor Czarev on 3/22/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCAddItemTableViewController.h"

@interface KCAddItemTableViewController ()

@property (strong, nonatomic) CFClassItem *model;

@end

@implementation KCAddItemTableViewController


#pragma mark - Custom accessors

- (CFClassItem *)model {
    if (!_model) {
        _model = [[CFClassItem alloc] init];
    }
    return _model;
}

#pragma mark - Actions

- (IBAction)nameTextFieldEditingChanged:(UITextField *)textField {
    self.model.name = textField.text;
}

- (IBAction)typeTextFieldEditingChanged:(UITextField *)textField {
    self.model.type = textField.text;
}

- (IBAction)markTextFieldEditingChanged:(UITextField *)textField {
    self.model.mark = @(textField.text.integerValue);
}

- (IBAction)weightTextFieldEditingChanged:(UITextField *)textField {
    self.model.weight = @(textField.text.integerValue);
}

- (IBAction)doneBarButtonAction:(id)sender {
    CFClassItem *item = self.model;
    
    if (!item.name.length || !item.type.length || !item.weight || !item.mark) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(addItemTableViewController:didCreateItem:)]) {
        [self.delegate addItemTableViewController:self didCreateItem:self.model];
    }
}

@end
