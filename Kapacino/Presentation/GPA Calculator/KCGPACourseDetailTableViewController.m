//
//  KCGPACourseTableViewController.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-04.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "KCGPACourseDetailTableViewController.h"
@import Firebase;
@import TTGSnackbar;

#import "KCAPIClient.h"
#import "Course.h"
#import "ProfessorInfoDatasource.h"
#import "InfoProfessor.h"
#import "CourseInfoDatasource.h"
#import "InfoSchoolCourse.h"

static NSString *const kShowAutocompleteSegue = @"showAutocomplete";

@interface KCGPACourseDetailTableViewController()
    @property (weak, nonatomic) IBOutlet UITextField *textfieldCreditWeight;
    @property (weak, nonatomic) IBOutlet UITextField *textfieldCreditType;
    @property (weak, nonatomic) IBOutlet UITextField *textfieldInstructor;
    @property (weak, nonatomic) IBOutlet UITextField *textfieldTerm;
    @property (weak, nonatomic) IBOutlet UITextField *textfieldCourseName;
    @property (weak, nonatomic) IBOutlet UITextField *textfieldCourseCode;
@end

@implementation KCGPACourseDetailTableViewController

//TODO Show user if there is something wrong with input
-(void) viewDidLoad
{
    //TODO Filter for professors from the given school
    
    if (self.course)
    {
//        self.textfieldCourseName.text = self.course.courseName;
        self.textfieldTerm.text = self.course.term;
        self.textfieldCreditType.text = self.course.creditType;
//        self.textfieldCreditWeight.text = self.course.creditWeight
        
        //Get instructor name from id
        self.textfieldInstructor.text = self.course.instructorId;
        InfoProfessor* professor = [[ProfessorInfoDatasource instance] getById:self.course.instructorId];
        self.textfieldInstructor.text = professor.fullName;
        
        self.textfieldCourseName.text = self.course.instructorId;
        InfoSchoolCourse* course = [[CourseInfoDatasource instance] getById:self.course.courseId];
        self.textfieldCourseName.text = course.name;
        self.textfieldCourseCode.text = course.code;
        
//        NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
        self.textfieldCreditWeight.text = [NSString stringWithFormat:@"%@", self.course.creditWeight];
    }
    else
    {
        FIRDatabaseReference* coursesRef = [[KCAPIClient sharedClient] coursesReference];
        self.course = [[Course alloc] init];
        self.course.key = [coursesRef childByAutoId].key;
    }
}

- (IBAction)onDoneTapped:(id)sender {
    if ([self saveData])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(BOOL) navigationShouldPopOnBackButton {
    return [self saveData];
}

-(BOOL) saveData
{
    //    NSString *userID = [FIRAuth auth].currentUser.uid;
    
    FIRDatabaseReference* coursesRef = [[KCAPIClient sharedClient] coursesReference];
    
    self.course.term = self.textfieldTerm.text;
    self.course.creditType = self.textfieldCreditType.text;
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    self.course.creditWeight = [f numberFromString:self.textfieldCreditWeight.text];
    
    if (!self.course.term.length)
    {
        //Notify user of error
        TTGSnackbar* snackbar = [[TTGSnackbar alloc] initWithMessage:@"Invalid term" duration:TTGSnackbarDurationShort];
        [snackbar show];
    }
    else if (!self.course.instructorId.length)
    {
        //Notify user of error
        TTGSnackbar* snackbar = [[TTGSnackbar alloc] initWithMessage:@"Invalid instructor" duration:TTGSnackbarDurationShort];
        [snackbar show];
    }
    else if (!self.course.creditType.length)
    {
        //Notify user of error
        TTGSnackbar* snackbar = [[TTGSnackbar alloc] initWithMessage:@"Invalid credit type" duration:TTGSnackbarDurationShort];
        [snackbar show];
    }
    else if (self.course.creditWeight == nil)
    {
        //Notify user of error
        TTGSnackbar* snackbar = [[TTGSnackbar alloc] initWithMessage:@"Invalid credit weight" duration:TTGSnackbarDurationShort];
        [snackbar show];
    }
    else if ([self.course isComplete])
    {
        NSDictionary *courseAsDictionary = [self.course toDictionary];
        
        //TODO Use user id and access control
        NSDictionary *childUpdates = @{self.course.key: courseAsDictionary};
        [coursesRef updateChildValues:childUpdates];
        return YES;
    }
    else
    {
        //Notify user of error
        TTGSnackbar* snackbar = [[TTGSnackbar alloc] initWithMessage:@"Invalid course details" duration:TTGSnackbarDurationShort];
        [snackbar show];
    }
    
    return NO;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    long row = indexPath.row;
    
    if (row == 1)
    {
        row = 0;
    }
    
    switch (row) {
        case 0:
            [self performSegueWithIdentifier:kShowAutocompleteSegue sender:@(row)];
            break;
        case 2:
            [self.textfieldTerm becomeFirstResponder];
            break;
        case 3:
            [self performSegueWithIdentifier:kShowAutocompleteSegue sender:@(row)];
            break;
        case 4:
            [self.textfieldCreditType becomeFirstResponder];
            break;
        case 5:
            [self.textfieldCreditWeight becomeFirstResponder];
            break;
        default:
            break;
    }
}

-(void) configureAutocompleteWithRow:(KCGPAAutocompleteViewController*) vc andRow:(NSNumber*) row
{
    switch (row.intValue) {
        case 0:
            vc.autoCompleteDataSource = [CourseInfoDatasource sharedInstance];
            vc.title = @"Course Name";
            vc.defaultText = self.textfieldCourseName.text;
            break;
        case 3:
            vc.autoCompleteDataSource = [ProfessorInfoDatasource sharedInstance];
            vc.title = @"Instructor";
            vc.defaultText = self.textfieldInstructor.text;
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
    if ([object isKindOfClass:[InfoProfessor class]])
    {
        InfoProfessor* professor = (InfoProfessor*) object;
        self.textfieldInstructor.text = professor.fullName;
        self.course.instructorId = professor.uid;
    }
    else if ([object isKindOfClass:[InfoSchoolCourse class]])
    {
        InfoSchoolCourse* course = (InfoSchoolCourse*) object;
        self.course.courseId = course.uid;
        self.textfieldCourseName.text = course.name;
        self.textfieldCourseCode.text = course.code;
    }
}

@end
