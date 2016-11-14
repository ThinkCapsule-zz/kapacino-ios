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
#import "MarkTypeDatasource.h"

@import TTGSnackbar;
@import Firebase;

static NSString *const kShowWeightSegue = @"showWeight";
static NSString *const kShowMarkSegue = @"showMark";
static NSString *const kShowPickerSegue = @"showPicker";

@interface KCGPAMarksDetailViewController()
    @property (weak, nonatomic) IBOutlet UITextField *textfieldName;
    @property (weak, nonatomic) IBOutlet UITextField *textfieldType;
    @property (weak, nonatomic) IBOutlet UITextField *textfieldWeight;
    @property (weak, nonatomic) IBOutlet UITextField *textfieldMark;

    @property (strong, nonatomic) MarkTypeDatasource* markDatasource;

    @property (strong, nonatomic) NSString* lastSegueIdentifier;
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
    if ([self saveData])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(BOOL) navigationShouldPopOnBackButton {
    BOOL isSaved = [self saveData];
    
    TTGSnackbar* snackbar = [[TTGSnackbar alloc] initWithMessage:isSaved ? @"Saved" : @"Invalid data. Could not save" duration:TTGSnackbarDurationShort];
    [snackbar show];
    
    return YES;
}

-(BOOL) saveData
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
        TTGSnackbar* snackbar = [[TTGSnackbar alloc] initWithMessage:@"Could not save: Invalid name" duration:TTGSnackbarDurationShort];
        [snackbar show];
    }
    else if (!self.mark.type.length)
    {
        //Notify user of error
        TTGSnackbar* snackbar = [[TTGSnackbar alloc] initWithMessage:@"Could not save: Invalid type" duration:TTGSnackbarDurationShort];
        [snackbar show];
    }
    else if (self.mark.weight == nil)
    {
        //Notify user of error
        TTGSnackbar* snackbar = [[TTGSnackbar alloc] initWithMessage:@"Could not save: Invalid weight" duration:TTGSnackbarDurationShort];
        [snackbar show];
    }
    else if (self.mark.mark == nil)
    {
        //Notify user of error
        TTGSnackbar* snackbar = [[TTGSnackbar alloc] initWithMessage:@"Could not save: Invalid mark" duration:TTGSnackbarDurationShort];
        [snackbar show];
    }
    else
    {
        //TODO Use user id and access control
        NSDictionary *childUpdates = @{self.mark.key: [self.mark toDictionary]};
        [marksRef updateChildValues:childUpdates];
        return YES;
    }
    
    return NO;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self.textfieldName becomeFirstResponder];
            break;
        case 1:
            [self performSegueWithIdentifier:kShowPickerSegue sender:self.textfieldType];
            break;
        case 2:
            [self performSegueWithIdentifier:kShowWeightSegue sender:self.mark.weight];
            break;
        case 3:
            [self performSegueWithIdentifier:kShowMarkSegue sender:self.mark.mark];
            break;
        default:
            break;
    }
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kShowWeightSegue])
    {
        KCGPAMarksPercentageViewController* vc = segue.destinationViewController;
        vc.delegate = self;
        vc.defaultPercentage = self.mark.weight.floatValue;
    }
    else if ([segue.identifier isEqualToString:kShowMarkSegue])
    {
        KCGPAMarksPercentageViewController* vc = segue.destinationViewController;
        vc.delegate = self;
        vc.defaultPercentage = self.mark.mark.floatValue;
    }
    else if ([segue.identifier isEqualToString:kShowPickerSegue])
    {
        KCGPAPickerViewController* vc = segue.destinationViewController;
        vc.delegate = self;
        
        NSArray* candidates = @[
                                @"Attendance",
                                @"Essay",
                                @"Exam",
                                @"Midterm Exam",
                                @"Final Exam",
                                @"Assignment",
                                @"Quiz"];
        vc.candidates = candidates;
        
        if (self.mark.type)
        {
            vc.defaultIndex = (int) [vc.candidates indexOfObject:self.mark.type];
        }
        
        vc.sender = sender;
    }
    
    self.lastSegueIdentifier = segue.identifier;
}

-(void) didPercentageChange:(float)percentage
{
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    
    if ([self.lastSegueIdentifier isEqualToString:kShowWeightSegue])
    {
        self.textfieldWeight.text = [f stringFromNumber:@(percentage)];
        self.mark.weight = @(percentage);
    }
    else if ([self.lastSegueIdentifier isEqualToString:kShowMarkSegue])
    {
        self.textfieldMark.text = [f stringFromNumber:@(percentage)];
        self.mark.mark = @(percentage);
    }
}

-(void) didPickerSelectString:(NSString *)string forSender:(id) sender
{
    UITextField* textfield = (UITextField*) sender;
    textfield.text = string;
    
    if (textfield == self.textfieldType)
    {
        self.mark.type = string;
    }
}

@end
