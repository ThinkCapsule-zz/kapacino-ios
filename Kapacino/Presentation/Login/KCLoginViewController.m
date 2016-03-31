//
//  KCLoginViewController.m
//  Kapacino
//
//  Created by Igor Czarev on 3/31/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCLoginViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Firebase/Firebase.h>

@interface KCLoginViewController ()

@end

@implementation KCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)facebookButtonAction:(id)sender {
    
    Firebase *ref = [[Firebase alloc] initWithUrl:@"luminous-inferno-6931.firebaseio.com"];
    FBSDKLoginManager *facebookLogin = [[FBSDKLoginManager alloc] init];
    NSArray *permissions = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location", @"email" ];
    [facebookLogin logInWithReadPermissions:permissions fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            NSLog(@"Facebook login failed. Error: %@", error);
        } else if (result.isCancelled) {
            NSLog(@"Facebook login got cancelled.");
        } else {
            [ref authWithOAuthProvider:@"facebook" token:result.token.tokenString  withCompletionBlock:^(NSError *error, FAuthData *authData) {
                if (error) {
                    NSLog(@"Login failed. %@", error);
                } else {
                    NSDictionary *alanisawesome = @{ @"full_name" : @"Alan Turing", @"date_of_birth": @"June 23, 1912" };
                    NSDictionary *gracehop = @{ @"full_name" : @"Grace Hopper", @"date_of_birth": @"December 9, 1906" };
                    
                    Firebase *usersRef = [ref childByAppendingPath: @"users"];
                    NSDictionary *users = @{ @"alanisawesome": alanisawesome, @"gracehop": gracehop };
                    
                    [usersRef setValue: users];
                }
            }];
        }
    }];
}

@end
