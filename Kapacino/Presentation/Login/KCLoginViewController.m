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
#import "KCAPIClient.h"

@interface KCLoginViewController ()

@end

@implementation KCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)facebookButtonAction:(id)sender {
    
    FBSDKLoginManager *facebookLogin = [[FBSDKLoginManager alloc] init];
    NSArray *permissions = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location", @"email" ];
    [facebookLogin logInWithReadPermissions:permissions fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            NSLog(@"Facebook login failed. Error: %@", error);
        } else if (result.isCancelled) {
            NSLog(@"Facebook login got cancelled.");
        } else {
            [[KCAPIClient sharedClient] loginUserWithProvider:@"facebook" token:result.token.tokenString success:^(FAuthData *authData) {
                [[KCAPIClient sharedClient] getUserByID:authData.uid success:^(NSDictionary *userData) {
                    
                } failure:^(NSError *error) {
                    
                }];
            } failure:nil];
            
        }
    }];
}

@end
