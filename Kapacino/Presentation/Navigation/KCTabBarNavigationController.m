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
#import "KCArticleViewController.h"
#import "KCSettingsViewController.h"
#import "KCGPACalcViewController.h"
#import "PreflightManager.h"
#import "KCNavigationController.h"
#import "KCAPIClient.h"
#import "User.h"
#import "KCAPIClient.h"

typedef NS_ENUM(NSInteger, KCTabBarItems) {
    KCTabBarItems_Home = 0,
    KCTabBarItems_Calc,
    KCTabBarItems_Profile,
    KCTabBarItems_Setting,
    KCTabBarItems_Count,
};

@interface  KCTabBarNavigationController()

@property (nonatomic, strong) KCNavigationController *articleVC;
@property (nonatomic, strong) KCNavigationController *discoverVC;
@property (nonatomic, strong) KCNavigationController *profileVC;
@property (nonatomic, strong) KCNavigationController *gpaCalcVC;
@property (nonatomic, strong) KCSettingsViewController *settingsVC;


@end

@implementation KCTabBarNavigationController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [[FIRAuth auth] signOut:nil];
    
    [[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth,
                                                    FIRUser *_Nullable user) {
        if (user != nil) {
            // User is signed in.
            [[[KCAPIClient sharedClient] usersReferenceForCurrentUser] observeEventType:FIRDataEventTypeValue
                withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
                    UserInfo* userInfo = [[UserInfo alloc] init:snapshot];
                    if (!userInfo.isComplete)
                    {
                        KCUserInformationViewController *userInfoVC = [[UIStoryboard storyboardWithName:@"User Information" bundle:nil] instantiateInitialViewController];
                        userInfoVC.user = [[User alloc] initWithUser:user andInfo:userInfo];
                        userInfoVC.delegate = self;
                        
                        UINavigationController* navController = [[UINavigationController alloc]initWithRootViewController:userInfoVC];
                        
                        [self presentViewController:navController animated:YES completion:nil];
                    }
                }];
        } else {
            // No user is signed in.
            UIViewController *loginVC = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateInitialViewController];
            [self presentViewController:loginVC animated:YES completion:nil];
        }
    }];
    
//    if (![KCAPIClient sharedClient].currentUserID) {
//        UIViewController *loginVC = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateInitialViewController];
//        [self presentViewController:loginVC animated:YES completion:nil];
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor kc_ApplicationColor]];
    self.tabBar.tintColor = [UIColor kc_ApplicationColor];
    
    [self setViewControllers:@[self.articleVC, self.discoverVC, self.gpaCalcVC, self.settingsVC]];

}

#pragma mark - Getter

- (KCNavigationController *)articleVC {
    
    /* Main Feed */
    if (!_articleVC) {
        KCArticleViewController *articleVC = [[KCArticleViewController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        _articleVC = [[KCNavigationController alloc] initWithRootViewController:articleVC];
        _articleVC.tabBarItem.image = [UIImage imageNamed:@"tab_bar_home"];
    }
    return _articleVC;
    
}

- (KCNavigationController *)discoverVC{
    
    /*listings, places, events*/
    if (!_discoverVC){
//        KCMainViewController *discoverVC = [[KCDiscoverViewController alloc] initWithCollectionViewLayout: [[UICollectionViewFlowLayout alloc] init]];
//        _discoverVC = [[KCNavigationController alloc] initWithRootViewController:discoverVC];
//        //TODO needs to be updated with new images from Alyssa
//        _discoverVC.tabBarItem.image = [UIImage imageNamed: @"tab_bar_discover"];
        _discoverVC = [[UIStoryboard storyboardWithName:@"Discover" bundle:nil] instantiateInitialViewController];
        _discoverVC.tabBarItem.image = [UIImage imageNamed:@"tab_bar_discover"];
    }
    return _discoverVC;
}

- (KCNavigationController *)profileVC{
    /*user profile*/
    if(_profileVC){
        _profileVC = [[UIStoryboard storyboardWithName:@"Profile" bundle:nil]instantiateInitialViewController];
    }
    return _profileVC;
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
        _settingsVC = [[UIStoryboard storyboardWithName:@"Settings" bundle:nil] instantiateInitialViewController];        
        _settingsVC.tabBarItem.image = [UIImage imageNamed:@"tab_bar_setting"];
    }
    return _settingsVC;
    
}

-(void) onInfoFinished
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
