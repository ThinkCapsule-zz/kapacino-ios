//
//  KCAddItemTableViewController.m
//  Kapacino
//
//  Created by Igor Czarev on 3/22/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCAddItemTableViewController.h"
#import "KCPickerTableViewController.h"

@interface KCAddItemTableViewController () <KCPickerTableViewControllerDelegate>

@property (strong, nonatomic) CFClassItem *model;
@property (weak, nonatomic) IBOutlet UITextField *typeTextField;

@end

@implementation KCAddItemTableViewController


#pragma mark - Custom accessors

- (CFClassItem *)model {
    if (!_model) {
        _model = [[CFClassItem alloc] init];
    }
    return _model;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        KCPickerTableViewController *pickerController = [[UIStoryboard storyboardWithName:@"User Information" bundle:nil] instantiateViewControllerWithIdentifier:@"KCPickerTableViewController"];
        pickerController.categoryName = @"Type*";
        pickerController.delegate = self;
        NSArray *items = @[ @"Assignment", @"Guiz", @"Test", @"Exam"];
        pickerController.items = items;
        [self.navigationController pushViewController:pickerController animated:YES];
    }
}

#pragma mark - Actions

- (IBAction)nameTextFieldEditingChanged:(UITextField *)textField {
    self.model.name = textField.text;
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

- (void)pickerTableViewController:(KCPickerTableViewController *)controller didChangeUserInfo:(NSMutableDictionary *)userInfo {
    NSString *type = [userInfo objectForKey:@"Type"];
    self.model.type = type;
    self.typeTextField.text = type;
}

@end
