//
//  KCSchoolInformationViewController.m
//  Kapacino
//
//  Created by Igor Czarev on 4/1/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCSchoolInformationViewController.h"
#import "KCSchoolInformationTableViewController.h"
#import "KCAPIClient.h"
#import "KCLoadingPage.h"

@interface KCSchoolInformationViewController ()

@property (strong, nonatomic) KCSchoolInformationTableViewController *schoolInformationTableViewController;

@end

@implementation KCSchoolInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageControl.currentPage = 2;
}

- (void)updateUserInfo {
    NSString *userID = [KCAPIClient sharedClient].currentUserID ;
    [self.userInfo setValue:@"YES" forKey:@"complete"];
    [[KCAPIClient sharedClient] updateUserWithID:userID userInfo:self.userInfo success:^(Firebase *userRef) {
        KCLoadingPage *loadingPageViewConrtoller = [[UIStoryboard storyboardWithName:@"User Information" bundle:nil] instantiateViewControllerWithIdentifier:@"KCLoadingPage"];
        [self.navigationController setViewControllers:@[loadingPageViewConrtoller] animated:YES];
    } failure:nil];
}

- (BOOL)checkUserInfo {
    self.userInfo = self.schoolInformationTableViewController.userInfo;
    NSString *countryOfSchool = [self.userInfo objectForKey:@"Country of school"];
    NSString *school = [self.userInfo objectForKey:@"School"];
    NSString *major = [self.userInfo objectForKey:@"Major"];
    NSString *currently = [self.userInfo objectForKey:@"I'm currently a(n)"];
    if (!countryOfSchool || !school || !major || !currently) {
        return NO;
    }
    return YES;
}

- (IBAction)startExploringButtonAction:(UIButton *)sender {
    if ([self checkUserInfo]) {
        [self updateUserInfo];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[KCSchoolInformationTableViewController class]]) {
        self.schoolInformationTableViewController = segue.destinationViewController;
        self.schoolInformationTableViewController.userInfo = self.userInfo;
    }
}

@end
