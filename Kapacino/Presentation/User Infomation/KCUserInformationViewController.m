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

@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (strong, nonatomic) KCUserInfoTableViewController *userInfoTebleViewController;

@end

@implementation KCUserInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *userName = [self.userInfo objectForKey:@"Name"];
    if (userName) {
        NSString *firstName = [[userName componentsSeparatedByString:@" "] firstObject];
        self.headerLabel.text = [NSString stringWithFormat:@"Hello %@",firstName ];
    } else {
        self.headerLabel.text = @"Hello";
    }
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"showSchoolInfo"]) {
        self.userInfo = self.userInfoTebleViewController.userInfo;
        NSString *userName = [self.userInfo objectForKey:@"Name"];
        NSString *gender = [self.userInfo objectForKey:@"Gender"];
        NSString *country = [self.userInfo objectForKey:@"Country"];
        NSString *hometown = [self.userInfo objectForKey:@"Hometown"];
        if (!userName.length || !gender || !country || !hometown) {
            return NO;
        }
    }
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[KCUserInfoTableViewController class]]) {
        self.userInfoTebleViewController = segue.destinationViewController;
        self.userInfoTebleViewController.userInfo = self.userInfo;
    } else if ([segue.identifier isEqualToString:@"showSchoolInfo"]) {
        KCSchoolInformationViewController *schoolInformationViewController = segue.destinationViewController;
        schoolInformationViewController.userInfo = self.userInfo;
    }
}

@end
