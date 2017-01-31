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
             if ([self.delegate respondsToSelector:@selector(onInfoFinished)])
             {
                 [self.delegate onInfoFinished];
             }
         }];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[KCSchoolInformationTableViewController class]]) {
        self.schoolInformationTableViewController = segue.destinationViewController;
        self.schoolInformationTableViewController.user = self.user;
    }
}

@end
