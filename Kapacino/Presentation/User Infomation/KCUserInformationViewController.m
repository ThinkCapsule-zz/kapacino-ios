//
//  KCUserInformationViewController.m
//  Kapacino
//
//  Created by Igor Czarev on 4/1/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCUserInformationViewController.h"
#import "KCUserInfoTableViewController.h"
#import "KCAPIClient.h"

@interface KCUserInformationViewController ()

@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (strong, nonatomic) KCUserInfoTableViewController *userInfoTebleViewController;

@end

@implementation KCUserInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *userName = [self.userInfo objectForKey:@"FirstName"];
    if (userName) {
        self.headerLabel.text = [NSString stringWithFormat:@"Hello %@",userName];
    } else {
        self.headerLabel.text = @"Hello";
    }
}

- (IBAction)nextButtonAction:(id)sender {
    NSString *userID = [KCAPIClient sharedClient].currentUserID ;
    NSMutableDictionary *userInfo = self.userInfoTebleViewController.userInfo;
    //[userInfo setValue:@"YES" forKey:@"complete"];
    [[KCAPIClient sharedClient] updateUserWithID:userID userInfo:userInfo success:^(Firebase *userRef) {
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[KCUserInfoTableViewController class]]) {
        self.userInfoTebleViewController = segue.destinationViewController;
        self.userInfoTebleViewController.userInfo = self.userInfo;
    }
}

@end
