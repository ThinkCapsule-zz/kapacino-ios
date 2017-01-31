//
//  KCLoginViewController.m
//  Kapacino
//
//  Created by Igor Czarev on 3/31/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCLoginViewController.h"
#import <Firebase/Firebase.h>
#import "KCAPIClient.h"
#import "KCUserInformationViewController.h"
#import "KCNavigationController.h"

@interface KCLoginViewController ()

@end

@implementation KCLoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}


- (void)loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
              error:(NSError *)error {
    if (result.isCancelled) {
        NSLog(@"Facebook login got cancelled.");
    }
    else if (error == nil)
    {
        FIRAuthCredential *credential = [FIRFacebookAuthProvider
                                         credentialWithAccessToken:[FBSDKAccessToken currentAccessToken]
                                         .tokenString];
        [[FIRAuth auth] signInWithCredential:credential
                                  completion:^(FIRUser *user, NSError *error) {
//            //Save profile info from Facebook in Firebase
//            NSArray* providerData = user.providerData;
//            for (id<FIRUserInfo> profile in providerData)
//            {
//                NSString* providerId = profile.providerID;
//                NSString* uid = profile.uid;  // Provider-specific UID
//                NSString* name = profile.displayName;
//                NSString* email = profile.email;
//                NSString* photoUrl = profile.photoURL;
//            }
                                      
              if ([FBSDKAccessToken currentAccessToken])
              {
                  NSDictionary *permissions = @{@"fields" : @"id,name,email,birthday,gender"};
                  [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:permissions]
                   startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                       if (!error) {
                           NSString* gender = result[@"gender"];
                           
                           if (gender)
                           {
                               FIRDatabaseReference* usersRef = [[KCAPIClient sharedClient] usersReferenceForCurrentUser];
                                NSDictionary *genderUpdate = @{@"gender": gender};
                                [usersRef updateChildValues:genderUpdate];
                           }

                           //Dismiss
                           [self dismissViewControllerAnimated:YES completion:nil];
                       }
                       else{
                           NSLog(@"%@", [error localizedDescription]);
                       }
                   }];
              }
          }];
    }
    else
    {
        NSLog(@"%@", error.localizedDescription);
    }
}

-(void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
//    FBSDKLoginManager *facebookLogin = [[FBSDKLoginManager alloc] init];
    
}

- (IBAction)facebookButtonAction:(id)sender {
    
    
//    FBSDKLoginManager *facebookLogin = [[FBSDKLoginManager alloc] init];
//    NSArray *permissions = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location", @"email" ];
//    [facebookLogin logInWithReadPermissions:permissions fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
//        if (error) {
//            NSLog(@"Facebook login failed. Error: %@", error);
//        } else if (result.isCancelled) {
//            NSLog(@"Facebook login got cancelled.");
//        } else {
//            [[KCAPIClient sharedClient] loginUserWithProvider:@"facebook" token:result.token.tokenString success:^(FAuthData *authData) {
//                [[KCAPIClient sharedClient] getUserByID:authData.uid success:^(NSDictionary *userData, BOOL completeUserProfile) {
//                    if (completeUserProfile) {
//                        KCUserInformationViewController *userInfoVC = [[UIStoryboard storyboardWithName:@"User Information" bundle:nil] instantiateInitialViewController];
//                        userInfoVC.userInfo =[NSMutableDictionary dictionaryWithDictionary:userData];
//                        [self.navigationController setViewControllers:@[ userInfoVC ] animated:YES];
//                    } else {
//                        NSDictionary *facebookUserInfo = [authData.providerData objectForKey:@"cachedUserProfile"];
//                        NSString *name = [facebookUserInfo objectForKey:@"name"];
//                        NSString *gender = [facebookUserInfo objectForKey:@"gender"];
//                        NSString *email = [facebookUserInfo objectForKey:@"email"];
//                        NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
//                        [userInfo setObject:name forKey:@"Name"];
//                        [userInfo setObject:gender forKey:@"Gender"];
//                        [userInfo setObject:email forKey:@"Email"];
//                        [[KCAPIClient sharedClient] createUserWithID:authData.uid userInfo:userInfo success:^(Firebase *userRef) {
//                            KCUserInformationViewController *userInfoVC = [[UIStoryboard storyboardWithName:@"User Information" bundle:nil] instantiateInitialViewController];
//                            userInfoVC.userInfo = userInfo;
//                            [self.navigationController setViewControllers:@[ userInfoVC ] animated:YES];
//                        } failure:nil];
//                    }
//                } failure:nil];
//            } failure:nil];
//        }
//    }];
}

@end
