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

@interface KCSchoolInformationViewController ()

@property (strong, nonatomic) KCSchoolInformationTableViewController *schoolInformationTableViewController;

@end

@implementation KCSchoolInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageControl.currentPage = 2;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[KCSchoolInformationTableViewController class]]) {
        self.schoolInformationTableViewController = segue.destinationViewController;
        self.schoolInformationTableViewController.userInfo = self.userInfo;
    }
}

- (IBAction)startExploringButtonAction:(id)sender {
    NSString *userID = [KCAPIClient sharedClient].currentUserID ;
    NSMutableDictionary *userInfo = self.schoolInformationTableViewController.userInfo;
    //[userInfo setValue:@"YES" forKey:@"complete"];
    [[KCAPIClient sharedClient] updateUserWithID:userID userInfo:userInfo success:^(Firebase *userRef) {
        
    } failure:^(NSError *error) {
        
    }];
}

@end
