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
#import "KCUserInformationViewController.h"
#import "KCNavigationController.h"

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
                [[KCAPIClient sharedClient] getUserByID:authData.uid success:^(NSDictionary *userData, BOOL completeUserProfile) {
                    if (completeUserProfile) {
                        [self dismissViewControllerAnimated:YES completion:nil];
                    } else {
                        NSDictionary *facebookUserInfo = [authData.providerData objectForKey:@"cachedUserProfile"];
                        NSString *name = [facebookUserInfo objectForKey:@"name"];
                        NSString *gender = [facebookUserInfo objectForKey:@"gender"];
                        NSString *email = [facebookUserInfo objectForKey:@"email"];
                        NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
                        [userInfo setObject:name forKey:@"Name"];
                        [userInfo setObject:gender forKey:@"Gender"];
                        [userInfo setObject:email forKey:@"Email"];
                        [[KCAPIClient sharedClient] createUserWithID:authData.uid userInfo:userInfo success:^(Firebase *userRef) {
                            KCUserInformationViewController *userInfoVC = [[UIStoryboard storyboardWithName:@"User Information" bundle:nil] instantiateInitialViewController];
                            userInfoVC.userInfo = userInfo;
                            [self.navigationController setViewControllers:@[ userInfoVC ] animated:YES];
                        } failure:nil];
                    }
                } failure:nil];
            } failure:nil];
        }
    }];
}

@end
