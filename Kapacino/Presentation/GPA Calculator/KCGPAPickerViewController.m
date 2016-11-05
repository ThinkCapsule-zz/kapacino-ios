//
//  KCGPAPickerViewController.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-11-04.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "KCGPAPickerViewController.h"

@interface KCGPAPickerViewController ()
    @property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@end

@implementation KCGPAPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.pickerView selectRow:self.defaultIndex inComponent:0 animated:YES];
    [self updateRowColor:self.pickerView didSelectRow:self.defaultIndex inComponent:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self updateRowColor:pickerView didSelectRow:row inComponent:component];
    
    if ([self.delegate respondsToSelector:@selector(didPickerSelectString:forSender:)])
    {
        [self.delegate didPickerSelectString:self.candidates[row] forSender:self.sender];
    }
}

-(void) updateRowColor:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    UILabel *labelSelected = (UILabel*)[pickerView viewForRow:row forComponent:component];
    if (row == [self.pickerView selectedRowInComponent:component])
    {
        labelSelected.textColor = [UIColor whiteColor];
        labelSelected.backgroundColor = [UIColor colorWithRed:255/255 green:102/255 blue:102/255 alpha:1];
    }
    else
    {
        labelSelected.textColor = [UIColor colorWithRed:155/255 green:155/255 blue:155/255 alpha:1];
        labelSelected.backgroundColor = [UIColor whiteColor];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.candidates[row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.candidates.count;
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* tView = (UILabel*)view;
    if (!tView)
    {
        tView = [[UILabel alloc] init];
        tView.font = [UIFont fontWithName:@"Avenir" size:24];
        tView.textAlignment = NSTextAlignmentCenter;
        tView.numberOfLines=3;
    }
    
    // Fill the label text here
    tView.text= self.candidates[row];
    
    return tView;
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
