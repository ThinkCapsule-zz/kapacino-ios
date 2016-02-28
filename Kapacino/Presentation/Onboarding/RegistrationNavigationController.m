//
//  RegistrationNavigationController.m
//  Kapacino
//
//  Created by Alan Hsu on 2016-02-27.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "RegistrationNavigationController.h"
#import "UserRegistrationViewController.h"
#import "SchoolRegistrationViewController.h"
#import "PreflightManager.h"

#import "UIColor+KCAdditions.h"

@interface RegistrationNavigationController () <UserRegistrationViewControllerDelegate, SchoolRegistrationViewControllerDelegate>

@property (nonatomic, strong) UserRegistrationViewController   *userRegistrationVC;
@property (nonatomic, strong) SchoolRegistrationViewController *schoolRegistrationVC;

@end

@implementation RegistrationNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.translucent  = NO;
    self.navigationBar.barTintColor = [UIColor kc_ApplicationColor];
    self.navigationBar.tintColor    = [UIColor whiteColor];

    self.viewControllers            = @[self.userRegistrationVC];
}

#pragma mark - Getters

- (UserRegistrationViewController *)userRegistrationVC {
    if (!_userRegistrationVC) {
        _userRegistrationVC = [[UserRegistrationViewController alloc] init];
        _userRegistrationVC.delegate = self;
    }
    return _userRegistrationVC;
}

- (SchoolRegistrationViewController *)schoolRegistrationVC {
    if (!_schoolRegistrationVC) {
        _schoolRegistrationVC = [[SchoolRegistrationViewController alloc] init];
        _schoolRegistrationVC.delegate = self;
    }
    return _schoolRegistrationVC;
}

#pragma mark - SchoolRegistrationViewControllerDelegate

- (void)didCompleteSchoolRegistration:(BOOL)completed {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [[PreflightManager sharedInstance] didCompleteRegistrationFlow:YES];
    
}

#pragma mark - UserRegistrationViewControllerDelegate

- (void)didCompleteUserRegistration:(BOOL)completed {
    
    [self pushViewController:self.schoolRegistrationVC animated:YES];
}

#pragma mark - Memory

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
