//
//  KCUserInfoLabel.m
//  Kapacino
//
//  Created by Igor Czarev on 4/1/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCUserInfoLabel.h"

@implementation KCUserInfoLabel

-(void)awakeFromNib {
    [super awakeFromNib];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    UIColor *color = [UIColor redColor];
    NSRange range = [self.text rangeOfString:@"*"];
    [attributedString addAttributes:@{ NSForegroundColorAttributeName:color } range:range];
    self.attributedText = attributedString;
}

@end
