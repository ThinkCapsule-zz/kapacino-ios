//
//  KCEmailLoginViewController.m
//  Kapacino
//
//  Created by Igor Czarev on 4/4/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCEmailLoginViewController.h"
#import "KCAPIClient.h"
#import "KCUserInformationViewController.h"
#import "KCNavigationController.h"

@interface KCEmailLoginViewController ()

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;

@end


@implementation KCEmailLoginViewController


- (IBAction)emailTextFieldEditingChanged:(UITextField *)textField {
    self.email = textField.text;
}

- (IBAction)passwordTextFieldEditingChanged:(UITextField *)textField{
    self.password = textField.text;
}

- (IBAction)signUpButtonAction:(id)sender {
    
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setObject:self.email forKey:@"Email"];
    
    [[KCAPIClient sharedClient] loginUserWithEmail:self.email password:self.password success:^(FAuthData *authData) {
        [[KCAPIClient sharedClient] getUserByID:authData.uid success:^(NSDictionary *userData, BOOL completeUserProfile) {
            if (completeUserProfile) {
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                if (![userData isKindOfClass:[NSNull class]]) {
                    [self showUserInformationViewControllerWithUserInfo:[NSMutableDictionary dictionaryWithDictionary:userData]];
                } else {
                    [self showUserInformationViewControllerWithUserInfo:userInfo];
                }
            }
        } failure:nil];
    } failure:^(NSError *error) {
        if (error.code == -8) {
            [[KCAPIClient sharedClient] createUserWithEmail:self.email password:self.password success:^(Firebase *userRef) {
                [self showUserInformationViewControllerWithUserInfo:userInfo];
            } failure:nil];
        }
    }];
}

- (void)showUserInformationViewControllerWithUserInfo:(NSMutableDictionary *)userInfo {
    KCUserInformationViewController *userInfoVC = [[UIStoryboard storyboardWithName:@"User Information" bundle:nil] instantiateViewControllerWithIdentifier:@"KCUserInformationViewController"];
    userInfoVC.userInfo = userInfo;
    KCNavigationController *navigationController = [[KCNavigationController alloc] initWithRootViewController:userInfoVC];
    [self presentViewController:navigationController animated:YES completion:nil];
}

@end
