//
//  KCGPAAutocompleteViewController.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-11-03.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "KCGPAAutocompleteViewController.h"
#import "MLPAutoCompleteTextField.h"

@interface KCGPAAutocompleteViewController ()
    @property (weak, nonatomic) IBOutlet MLPAutoCompleteTextField *textfieldAutocomplete;
@end

@implementation KCGPAAutocompleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Mark type autocomplete
    if (self.autoCompleteDataSource)
    {
        self.textfieldAutocomplete.autoCompleteDataSource = self.autoCompleteDataSource;
        self.textfieldAutocomplete.autoCompleteParentView = self.view;
        self.textfieldAutocomplete.showAutoCompleteTableWhenEditingBegins = YES;
        self.textfieldAutocomplete.autoCompleteDelegate = self;
        self.textfieldAutocomplete.maximumNumberOfAutoCompleteRows = 15;
    }
    
    self.textfieldAutocomplete.placeholder = self.defaultText;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) autoCompleteTextField:(MLPAutoCompleteTextField *)textField didSelectAutoCompleteString:(NSString *)selectedString withAutoCompleteObject:(id<MLPAutoCompletionObject>)selectedObject forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.delegate respondsToSelector:@selector(didAutocompleteSelectObject:)])
    {
        [self.delegate didAutocompleteSelectObject:selectedObject];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
