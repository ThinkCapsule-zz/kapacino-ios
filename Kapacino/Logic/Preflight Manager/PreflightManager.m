//
//  PreflightManager.m
//  Kapacino
//
//  Created by Alan Hsu on 2016-02-27.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "PreflightManager.h"
#import "RegistrationNavigationController.h"

@interface PreflightManager()

@property (nonatomic, strong) UIViewController  *navigationController;
@property (nonatomic, strong) NSUserDefaults    *userDefaults;

@end

@implementation PreflightManager

+ (instancetype)sharedInstance {
    
    static dispatch_once_t token;
    static PreflightManager *singleton;
    
    dispatch_once(&token, ^{
        singleton = [[PreflightManager alloc] init];
    });
    
    return singleton;
}

- (void)updateWithNavigationController:(UIViewController *)navigationController {
    
    self.navigationController = navigationController;
}

- (void)runPreflight {
    
    BOOL userDidOnboardApp = [self.userDefaults boolForKey:userDidOnboardAppKey];
    
    /* If user has not onboarded before show the registration view controller */
    if (!userDidOnboardApp) {
        RegistrationNavigationController *userRegisterNavigationController = [[RegistrationNavigationController alloc] init];
        [self.navigationController presentViewController:userRegisterNavigationController animated:YES completion:nil];
        
    }
    
}

- (void)didCompleteRegistrationFlow:(BOOL)completed {
    [self.userDefaults setBool:completed forKey:userDidOnboardAppKey];
}

#pragma mark - Getters

- (NSUserDefaults *)userDefaults {
    if (!_userDefaults) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return _userDefaults;
}

@end
