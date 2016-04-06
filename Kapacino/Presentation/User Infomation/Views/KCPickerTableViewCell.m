//
//  KCPickerTableViewCell.m
//  Kapacino
//
//  Created by Igor Czarev on 4/1/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCPickerTableViewCell.h"
#import "UIColor+KCAdditions.h"

@implementation KCPickerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectedBackgroundView = [[UIView alloc] init];
    self.selectedBackgroundView.backgroundColor = [UIColor kc_ApplicationColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        self.title.textColor = [UIColor whiteColor];
        self.titleLeftConstaint.constant = 30;
    } else {
        self.title.textColor = [UIColor lightGrayColor];
        self.titleLeftConstaint.constant = 50;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.selectedBackgroundView.frame = CGRectInset(self.selectedBackgroundView.frame, 10, 0);
}

@end
