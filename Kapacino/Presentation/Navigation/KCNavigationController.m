//
//  KCNavigationController.m
//  Kapacino
//
//  Created by Alan Hsu on 2016-02-29.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCNavigationController.h"
#import "UIColor+KCAdditions.h"

@implementation KCNavigationController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationBar setTranslucent:NO];
    [self.navigationBar setBarTintColor:[UIColor kc_ApplicationColor]];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName: [UIColor whiteColor] }];
}

@end
