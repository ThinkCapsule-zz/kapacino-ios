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
#import "KCNavigationController.h"
#import "KCAPIClient.h"

typedef NS_ENUM(NSInteger, KCTabBarItems) {
    KCTabBarItems_Home = 0,
    KCTabBarItems_Calc,
    KCTabBarItems_Profile,
    KCTabBarItems_Setting,
    KCTabBarItems_Count,
};

@interface  KCTabBarNavigationController()

@property (nonatomic, strong) KCNavigationController *mainVC;
@property (nonatomic, strong) KCNavigationController *gpaCalcVC;
@property (nonatomic, strong) KCSettingsViewController *settingsVC;


@end

@implementation KCTabBarNavigationController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
////    if (![KCAPIClient sharedClient].currentUserID) {
//        UIViewController *loginVC = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateInitialViewController];
//        [self presentViewController:loginVC animated:YES completion:nil];
//    //}
        UIViewController *userInfoVC = [[UIStoryboard storyboardWithName:@"User Information" bundle:nil] instantiateInitialViewController];
        [self presentViewController:userInfoVC animated:YES completion:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor kc_ApplicationColor]];
    self.tabBar.tintColor = [UIColor kc_ApplicationColor];
    
    [self setViewControllers:@[self.mainVC, self.gpaCalcVC, self.settingsVC]];

}

#pragma mark - Getter

- (KCNavigationController *)mainVC {
    
    /* Main Feed */
    if (!_mainVC) {
        KCMainViewController *mainVC = [[KCMainViewController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        _mainVC = [[KCNavigationController alloc] initWithRootViewController:mainVC];
        _mainVC.tabBarItem.image = [UIImage imageNamed:@"tab_bar_home"];
    }
    return _mainVC;
    
}

- (KCNavigationController *)gpaCalcVC {
    
    /* GPA Calc */
    if (!_gpaCalcVC) {
        _gpaCalcVC = [[UIStoryboard storyboardWithName:@"GPA" bundle:nil] instantiateInitialViewController];
    }
    return _gpaCalcVC;
}

- (KCSettingsViewController *)settingsVC {
    
    /* Settings view controller */
    if (!_settingsVC) {
        _settingsVC = [[KCSettingsViewController alloc] init];
        _settingsVC.view.backgroundColor = [UIColor blueColor];
        _settingsVC.tabBarItem.image = [UIImage imageNamed:@"tab_bar_setting"];
    }
    return _settingsVC;
    
}

@end
