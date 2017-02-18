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
@property (weak, nonatomic) IBOutlet UIButton *buttonNext;
    @property (strong, nonatomic) KCSchoolInformationTableViewController *schoolInformationTableViewController;

    @property (strong, nonatomic) UIColor* originalNextButtonColour;
@end

@implementation KCSchoolInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageControl.currentPage = 2;
    
    self.originalNextButtonColour = self.buttonNext.backgroundColor;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateNextButton];
}

-(void) updateNextButton
{
    BOOL isComplete = [self.user isComplete];
    self.buttonNext.enabled = isComplete;
    [self.buttonNext setBackgroundColor:isComplete ? self.originalNextButtonColour : [UIColor lightGrayColor]];
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
        self.schoolInformationTableViewController.delegate = self;
    }
}

-(void) onUniversityEmailChanged
{
    [self updateNextButton];
}

@end
