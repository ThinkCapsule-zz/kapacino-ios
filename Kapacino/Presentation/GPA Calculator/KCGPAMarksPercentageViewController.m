//
//  KCGPAMarksPercentageViewController.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-11-04.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "KCGPAMarksPercentageViewController.h"
#import "DALabeledCircularProgressView.h"

@interface KCGPAMarksPercentageViewController ()
    @property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressCircle;
    @property (weak, nonatomic) IBOutlet UISlider *slider;
    @property (nonatomic) float progressCurrent;
@end

static float kProgressStep = 1;

@implementation KCGPAMarksPercentageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.progressCircle.roundedCorners = YES;
    self.progressCircle.trackTintColor = [UIColor lightGrayColor];
    self.progressCircle.progressTintColor = [UIColor orangeColor];
    
    self.progressCurrent = self.defaultPercentage;
    self.slider.value = self.defaultPercentage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSliderChanged:(id)sender {
    UISlider* slider = sender;
    
    float roundedValue = round(slider.value / kProgressStep) * kProgressStep;

    slider.value = roundedValue;
    
    self.progressCurrent = slider.value;
}

-(void) setProgressCurrent:(float)progress
{
    self.progressCircle.progress = progress;
    self.progressCircle.progressLabel.text = [NSString stringWithFormat:@"%.0f", progress];
    
    if ([self.delegate respondsToSelector:@selector(didPercentageChange:)])
    {
        [self.delegate didPercentageChange:progress];
    }
}

-(IBAction) onDoneTapped:(id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
