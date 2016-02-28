//
//  KCTabBarNavigationController.m
//  Kapacino
//
//  Created by Alan Hsu on 2016-01-24.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCTabBarNavigationController.h"
#import "UIColor+KCAdditions.h"

/* View controllers */
#import "KCMainViewController.h"
#import "KCSettingsViewController.h"
#import "KCGPACalcViewController.h"
#import "PreflightManager.h"

@implementation KCTabBarNavigationController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = [UIColor kc_ApplicationColor];
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    
    /* Main Feed */
    KCMainViewController *mainVC = [[KCMainViewController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    [viewControllers addObject:mainVC];
    
//    /* GPA Calc */
//    KCGPACalcViewController *gpaCalcVC = [[KCGPACalcViewController alloc] init];
//    gpaCalcVC.view.backgroundColor = [UIColor redColor];
//    [viewControllers addObject:gpaCalcVC];
//    
//    /* Settings view controller */
//    KCSettingsViewController *settingsVC = [[KCSettingsViewController alloc] init];
//    settingsVC.view.backgroundColor = [UIColor blueColor];
//    [viewControllers addObject:settingsVC];
    
    self.viewControllers = [viewControllers copy];

}

@end
