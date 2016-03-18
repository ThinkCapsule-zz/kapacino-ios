//
//  KCInputCell.m
//  Kapacino
//
//  Created by How Else on 3/18/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCInputCell.h"

#import "UIColor+KCAdditions.h"

@implementation KCInputCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.layoutMargins = UIEdgeInsetsZero;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.textField];
        
        self.textLabel.textColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textField.frame = CGRectInset(self.contentView.bounds, 40, 0);
    self.textField.frame = CGRectOffset(self.textField.frame, 36, 0);
}

#pragma mark - Custom accessors

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.textColor = [UIColor kc_ApplicationColor];
        _textField.tintColor = [UIColor kc_ApplicationColor];
        [_textField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

#pragma mark - Actions

- (void)textFieldEditingChanged:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(inputCell:didChangeTextFieldText:)]) {
        [self.delegate inputCell:self didChangeTextFieldText:textField.text];
    }
}

@end
