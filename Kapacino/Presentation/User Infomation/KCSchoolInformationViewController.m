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

- (IBAction)onNextButtonTapped:(id)sender {
    if ([self.user isComplete])
    {
        [[KCAPIClient sharedClient] saveUser:self.user withCompletionHandler:^(NSError *error)
         {
             KCLoadingPage *loadingPageViewConrtoller = [[UIStoryboard storyboardWithName:@"User Information" bundle:nil] instantiateViewControllerWithIdentifier:@"KCLoadingPage"];
             
             [self presentViewController:loadingPageViewConrtoller animated:YES completion:nil];
         }];
    }
}

//TODO Remove if not used
- (BOOL)checkuser {
    self.user = self.schoolInformationTableViewController.user;
    
    //TODO Get school info from id
//    NSString *countryOfSchool = self.user.userInfo.schoolId;
    NSString *school = self.user.userInfo.schoolId;
    NSString *major = self.user.userInfo.major;
    NSString *minor = self.user.userInfo.minor;
//    NSString *currently = self.user.userInfo.locationCurrent;
    if (!school || !major || !minor) {
        return NO;
    }
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[KCSchoolInformationTableViewController class]]) {
        self.schoolInformationTableViewController = segue.destinationViewController;
        self.schoolInformationTableViewController.user = self.user;
    }
}

@end
