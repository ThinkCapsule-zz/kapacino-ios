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
@import Firebase;

@interface KCEmailLoginViewController ()

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;

@end


@implementation KCEmailLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
}


- (IBAction)emailTextFieldEditingChanged:(UITextField *)textField {
    self.email = textField.text;
}

- (IBAction)passwordTextFieldEditingChanged:(UITextField *)textField{
    self.password = textField.text;
}

- (IBAction)signUpButtonAction:(id)sender {
    
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setObject:self.email forKey:@"Email"];
    
    [[FIRAuth auth] signInWithEmail:self.email
                           password:self.password
                         completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
                             //TODO figure out how to get data
                             [self showUserInformationViewControllerWithUserInfo:nil];
                         }];
    
//    [[KCAPIClient sharedClient] loginUserWithEmail:self.email password:self.password completionHandler:^(FIRUser *user, NSError *error) {
////        [[KCAPIClient sharedClient] getUserByID:authData.uid success:^(NSDictionary *userData, BOOL completeUserProfile) {
////            if (completeUserProfile) {
////                [self showUserInformationViewControllerWithUserInfo:[NSMutableDictionary dictionaryWithDictionary:userData]];
////            } else {
//                if (![user isKindOfClass:[NSNull class]]) {
//                    [self showUserInformationViewControllerWithUserInfo:[NSMutableDictionary dictionaryWithDictionary:user]];
//                } else {
//                    [self showUserInformationViewControllerWithUserInfo:userInfo];
//                }
////            }
//        }];
    }
//   failure:^(NSError *error) {
//        if (error.code == -8 && [error.domain isEqualToString:@"FirebaseAuthentication"]) {
//            [[KCAPIClient sharedClient] createUserWithEmail:self.email password:self.password success:^(Firebase *userRef) {
//                [self showUserInformationViewControllerWithUserInfo:userInfo];
//            } failure:nil];
//        }
//    }
//     ];
//}

- (void)showUserInformationViewControllerWithUserInfo:(NSMutableDictionary *)userInfo {
    KCUserInformationViewController *userInfoVC = [[UIStoryboard storyboardWithName:@"User Information" bundle:nil] instantiateInitialViewController];
    userInfoVC.userInfo = userInfo;
    [self.navigationController setViewControllers:@[userInfoVC] animated:YES];
}

@end
