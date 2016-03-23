//
//  KCProfileLabel.m
//  Kapacino
//
//  Created by Igor Czarev on 3/25/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCProfileLabel.h"

@implementation KCProfileLabel

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowRadius = 2;
    self.layer.shadowOpacity = 0.7;
    self.layer.shadowOffset = CGSizeMake(0.0, 1.0);
}

@end
