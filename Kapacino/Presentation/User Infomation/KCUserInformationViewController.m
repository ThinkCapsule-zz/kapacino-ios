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

@property (strong, nonatomic) KCUserInfoTableViewController *userInfoTebleViewController;
@property (weak, nonatomic) IBOutlet UIButton *buttonNext;
@property (strong, nonatomic) UIColor* originalNextButtonColour;
@end

@implementation KCUserInformationViewController

NSString* const SEGUE_MORE = @"moreInfoSegue";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.originalNextButtonColour = self.buttonNext.backgroundColor;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self updateNextButton];
}

-(void) updateNextButton
{
    BOOL isComplete = [self checkUserInfo];
    self.buttonNext.enabled = isComplete;
    [self.buttonNext setBackgroundColor:isComplete ? self.originalNextButtonColour : [UIColor lightGrayColor]];
}

- (BOOL)checkUserInfo {
    self.user = self.userInfoTebleViewController.user;
    NSString *userName = self.user.name; // [self.userInfo objectForKey:@"Name"];
    NSString *school = self.user.userInfo.schoolId;
    NSString *major = self.user.userInfo.major;
    NSString *minor = self.user.userInfo.minor;
    NSString *yearOfStudy = self.user.userInfo.yearOfStudy;
    if (!userName.length || !school || !yearOfStudy || !major || !minor) {
        return NO;
    }
    return YES;
}

- (IBAction)onNextButtonTapped:(id)sender {
    if ([self checkUserInfo])
    {
        [self performSegueWithIdentifier:SEGUE_MORE sender:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[KCUserInfoTableViewController class]]) {
        self.userInfoTebleViewController = segue.destinationViewController;
        self.userInfoTebleViewController.user = self.user;
    } else if ([segue.identifier isEqualToString:SEGUE_MORE]) {
        KCSchoolInformationViewController *schoolInformationViewController = segue.destinationViewController;
        schoolInformationViewController.user = self.user;
        schoolInformationViewController.delegate = self;
    }
}

-(void) onInfoFinished
{
    if ([self.delegate respondsToSelector:@selector(onInfoFinished)])
    {
        [self.delegate onInfoFinished];
    }
}

@end
