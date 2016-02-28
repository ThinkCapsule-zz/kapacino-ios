//
//  RegistrationViewController.m
//  Kapacino
//
//  Created by Alan Hsu on 2016-02-27.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "UserRegistrationViewController.h"
#import "SchoolRegistrationViewController.h"
#import <KeepLayout/KeepLayout.h>
#import "UIColor+KCAdditions.h"
#import "UIFont+KCAdditions.h"

@interface UserRegistrationViewController ()

@property (nonatomic, strong) UIButton    *nextButton;
@property (nonatomic, strong) UILabel     *greetingLabel;
@property (nonatomic, strong) UILabel     *infoLabel;

@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *genderField;
@property (nonatomic, strong) UITextField *countryField;
@property (nonatomic, strong) UITextField *hometownField;

@end

@implementation UserRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor whiteColor]];

    [self.view addSubview:self.greetingLabel];
    [self.view addSubview:self.infoLabel];
    
    [self.view addSubview:self.nextButton];
    
    [self setupConstraints];
    
}

- (UILabel *)greetingLabel {
    if (!_greetingLabel) {
        _greetingLabel = [[UILabel alloc] init];
        _greetingLabel.text = @"Hello Anthony";
        _greetingLabel.textColor = [UIColor kc_ApplicationColor];
        _greetingLabel.textAlignment = NSTextAlignmentCenter;
        _greetingLabel.font = [UIFont kc_LightFontWithSize:35.0f];
    }
    return _greetingLabel;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.text = @"Please check if your information is correct.";
        _infoLabel.textColor = [UIColor kc_ApplicationColor];
        _infoLabel.textAlignment = NSTextAlignmentCenter;
        _infoLabel.font = [UIFont kc_MediumFontWithSize:12.0f];
    }
    return _infoLabel;
}

- (UIButton *)nextButton {
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.backgroundColor = [UIColor kc_ApplicationColor];
        [_nextButton setTitle:@"next" forState:UIControlStateNormal];
        [_nextButton addTarget:self action:@selector(completeUserRegistration) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

#pragma constraints

- (void)setupConstraints {
    
    self.greetingLabel.keepTopInset.equal = 20;
    self.greetingLabel.keepHorizontalInsets.equal = 0;
    
    self.infoLabel.keepTopOffsetTo(self.greetingLabel).equal = 10;
    self.infoLabel.keepHorizontalInsets.equal = 0;
    
    self.nextButton.keepBottomInset.equal      = 0;
    self.nextButton.keepHorizontalInsets.equal = 0;
    self.nextButton.keepHeight.equal           = 50;
}

- (void)completeUserRegistration {
 
    [self.delegate didCompleteUserRegistration:YES];
    
}

#pragma mark - Memory warning

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
