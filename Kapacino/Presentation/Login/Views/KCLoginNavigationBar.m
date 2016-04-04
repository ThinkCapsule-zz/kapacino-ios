//
//  KCLoginNavigationBar.m
//  Kapacino
//
//  Created by Igor Czarev on 4/4/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCLoginNavigationBar.h"
#import "UIColor+KCAdditions.h"

@implementation KCLoginNavigationBar

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.shadowImage = [UIImage new];
    self.tintColor = [UIColor whiteColor];
}

@end
