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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([self.delegate respondsToSelector:@selector(didPickerSelectString:forSender:)])
    {
        [self.delegate didPickerSelectString:self.candidates[row] forSender:self.sender];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
