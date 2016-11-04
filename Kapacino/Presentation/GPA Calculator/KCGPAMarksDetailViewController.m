//
//  KCGPAMarksDetailViewController.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-04.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "KCGPAMarksDetailViewController.h"
#import "KCAPIClient.h"
#import "Mark.h"
#import "MLPAutoCompleteTextField.h"
#import "MarkTypeDatasource.h"

@import TTGSnackbar;
@import Firebase;

static NSString *const kShowAutocompleteSegue = @"showAutocomplete";

@interface KCGPAMarksDetailViewController()
    @property (weak, nonatomic) IBOutlet UITextField *textfieldName;
    @property (weak, nonatomic) IBOutlet UITextField *textfieldType;
    @property (weak, nonatomic) IBOutlet UITextField *textfieldWeight;
    @property (weak, nonatomic) IBOutlet UITextField *textfieldMark;

    @property (strong, nonatomic) MarkTypeDatasource* markDatasource;
@end

@implementation KCGPAMarksDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    if (self.mark)
    {
        self.textfieldName.text = self.mark.name;
        self.textfieldType.text = self.mark.type;
        
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        self.textfieldMark.text = [f stringFromNumber:self.mark.mark];
        self.textfieldWeight.text = [f stringFromNumber:self.mark.weight];
    }    
}

//-(UITextField*) auto

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onDoneTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [self saveData];
}

-(void) saveData
{
    NSString *userID = [FIRAuth auth].currentUser.uid;
    
    FIRDatabaseReference* marksRef = [[KCAPIClient sharedClient] marksReference];
    
    //If it's a new mark
    if (!self.mark)
    {
        self.mark = [[Mark alloc] init];
        self.mark.key = [marksRef childByAutoId].key;
        self.mark.courseKey = self.courseKey;
    }
    
    self.mark.name = self.textfieldName.text;
    self.mark.type = self.textfieldType.text;
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    self.mark.weight = [f numberFromString:self.textfieldWeight.text];
    self.mark.mark = [f numberFromString:self.textfieldMark.text];
    
    if (!self.mark.name.length)
    {
        //Notify user of error
        TTGSnackbar* snackbar = [[TTGSnackbar alloc] initWithMessage:@"Invalid name" duration:TTGSnackbarDurationShort];
        [snackbar show];
    }
    else if (!self.mark.type.length)
    {
        //Notify user of error
        TTGSnackbar* snackbar = [[TTGSnackbar alloc] initWithMessage:@"Invalid type" duration:TTGSnackbarDurationShort];
        [snackbar show];
    }
    else if (self.mark.weight == nil)
    {
        //Notify user of error
        TTGSnackbar* snackbar = [[TTGSnackbar alloc] initWithMessage:@"Invalid weight" duration:TTGSnackbarDurationShort];
        [snackbar show];
    }
    else if (self.mark.mark == nil)
    {
        //Notify user of error
        TTGSnackbar* snackbar = [[TTGSnackbar alloc] initWithMessage:@"Invalid mark" duration:TTGSnackbarDurationShort];
        [snackbar show];
    }
    else
    {
        //TODO Use user id and access control
        NSDictionary *childUpdates = @{self.mark.key: [self.mark toDictionary]};
        [marksRef updateChildValues:childUpdates];        
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self.textfieldName becomeFirstResponder];
            break;
        case 1:
            [self performSegueWithIdentifier:kShowAutocompleteSegue sender:@(indexPath.row)];
            break;
        case 2:
            [self.textfieldWeight becomeFirstResponder];
            break;
        case 3:
            [self.textfieldMark becomeFirstResponder];
            break;
        default:
            break;
    }
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void) configureAutocompleteWithRow:(KCGPAAutocompleteViewController*) vc andRow:(NSNumber*) row
{
    switch (row.intValue) {
        case 1:
            vc.autoCompleteDataSource = [MarkTypeDatasource new];
            vc.title = @"Type";
            vc.defaultText = self.textfieldType.text;
            break;
        default:
            break;
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kShowAutocompleteSegue])
    {
        KCGPAAutocompleteViewController* vc = segue.destinationViewController;
        vc.delegate = self;
        
        [self configureAutocompleteWithRow:vc andRow:sender];
    }
}

-(void) didAutocompleteSelectString:(NSString *)string withObject:(id<MLPAutoCompletionObject>)object
{
    self.textfieldType.text = string;
    self.mark.type = string;
}


@end
