//
//  KCClassCell.m
//  Kapacino
//
//  Created by How Else on 3/18/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCClassCell.h"

#import "UIColor+KCAdditions.h"

@implementation KCClassCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        self.layoutMargins = UIEdgeInsetsZero;
        self.textLabel.textColor = [UIColor kc_ApplicationColor];
    }
    return self;
}

@end
