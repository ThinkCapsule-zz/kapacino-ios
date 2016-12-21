//
//  KCUserInformationViewController.m
//  Kapacino
//
//  Created by Igor Czarev on 4/1/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCUserInformationViewController.h"
#import "KCUserInfoTableViewController.h"
#import "KCSchoolInformationViewController.h"
#import "KCAPIClient.h"

@interface KCUserInformationViewController ()

@property (strong, nonatomic) KCUserInfoTableViewController *userInfoTebleViewController;

@end

@implementation KCUserInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
}

- (BOOL)checkUserInfo {
    self.user = self.userInfoTebleViewController.user;
    NSString *userName = self.user.name; // [self.userInfo objectForKey:@"Name"];
    NSString *gender = self.user.userInfo.gender;
    NSString *country = self.user.userInfo.country;
    NSString *hometown = self.user.userInfo.hometown;
    if (!userName.length || !gender || !country || !hometown) {
        return NO;
    }
    return YES;
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"showSchoolInfo"]) {
        return [self checkUserInfo];
    }
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[KCUserInfoTableViewController class]]) {
        self.userInfoTebleViewController = segue.destinationViewController;
        self.userInfoTebleViewController.user = self.user;
    } else if ([segue.identifier isEqualToString:@"showSchoolInfo"]) {
        KCSchoolInformationViewController *schoolInformationViewController = segue.destinationViewController;
        schoolInformationViewController.user = self.user;
    }
}

@end
