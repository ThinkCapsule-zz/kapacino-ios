//
//  KCLoginRoundedButton.m
//  Kapacino
//
//  Created by Igor Czarev on 4/4/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCLoginRoundedButton.h"

@implementation KCLoginRoundedButton

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 8;
}

@end
