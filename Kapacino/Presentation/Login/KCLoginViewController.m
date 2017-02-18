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
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *buttonFacebookLogin;

@end

@implementation KCLoginViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    self.buttonFacebookLogin.readPermissions =  @[@"public_profile", @"email"];
}

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
                           
                           NSString* email = result[@"email"];
                           
                           //Update email
                           if (email)
                           {
                               [[[FIRAuth auth] currentUser] updateEmail:email completion:nil];
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

@end
