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

- (void)updateuser {
    NSString *userID = [KCAPIClient sharedClient].currentUserID ;
    [self.user setValue:@"YES" forKey:@"complete"];
//    [[KCAPIClient sharedClient] updateUserWithID:userID user:self.user success:^(Firebase *userRef) {
//        KCLoadingPage *loadingPageViewConrtoller = [[UIStoryboard storyboardWithName:@"User Information" bundle:nil] instantiateViewControllerWithIdentifier:@"KCLoadingPage"];
//        [self.navigationController setViewControllers:@[loadingPageViewConrtoller] animated:YES];
//    } failure:nil];
}

- (BOOL)checkuser {
    self.user = self.schoolInformationTableViewController.user;
    
    //TODO Get school info from id
    NSString *countryOfSchool = @"Canada";
    NSString *school = @"UWaterloo";
    NSString *major = nil;
    NSString *currently = self.user.userInfo.locationCurrent;
    if (!countryOfSchool || !school || !major || !currently) {
        return NO;
    }
    return YES;
}

- (IBAction)startExploringButtonAction:(UIButton *)sender {
    if ([self checkuser]) {
        [self updateuser];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[KCSchoolInformationTableViewController class]]) {
        self.schoolInformationTableViewController = segue.destinationViewController;
        self.schoolInformationTableViewController.user = self.user;
    }
}

@end
