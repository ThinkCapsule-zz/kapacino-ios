//
//  SchoolRegistrationViewController.m
//  Kapacino
//
//  Created by Alan Hsu on 2016-02-27.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "SchoolRegistrationViewController.h"
#import "PreflightManager.h"
#import <KeepLayout/KeepLayout.h>
#import "UIColor+KCAdditions.h"

@interface SchoolRegistrationViewController ()

@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation SchoolRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.closeButton];

    [self setupConstraints];
    
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.backgroundColor = [UIColor kc_ApplicationColor];
        [_closeButton setTitle:@"close" forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(didCloseRegistration) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

#pragma mark - Constraints

- (void)setupConstraints {
    
    self.closeButton.keepBottomInset.equal      = 0;
    self.closeButton.keepHorizontalInsets.equal = 0;
    self.closeButton.keepHeight.equal           = 50;
}

#pragma mark - Action

- (void)didCloseRegistration {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate didCompleteSchoolRegistration:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
