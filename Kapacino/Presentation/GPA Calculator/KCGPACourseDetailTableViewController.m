//
//  KCGPACourseTableViewController.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-04.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "KCGPACourseDetailTableViewController.h"
@import Firebase;
#import "KCAPIClient.h"
#import "Course.h"
@import TTGSnackbar;

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
    if (self.course)
    {
        self.textfieldCourseName.text = self.course.courseName;
        self.textfieldCourseCode.text = self.course.term;
        self.textfieldTerm.text = self.course.term;
        self.textfieldCreditType.text = self.course.creditType;
        self.textfieldInstructor.text = self.course.instructor;
        
//        NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
//        formatter.f
        self.textfieldCreditWeight.text = [NSString stringWithFormat:@"%@", self.course.creditWeight];
    }
}

- (IBAction)onDoneTapped:(id)sender {
//    NSString *userID = [FIRAuth auth].currentUser.uid;
    
    FIRDatabaseReference* coursesRef = [[KCAPIClient sharedClient] coursesReference];

    NSString *key = [coursesRef childByAutoId].key;
    Course* course = [[Course alloc] init];
    course.courseCode = self.textfieldCourseCode.text;
    course.courseName = self.textfieldCourseName.text;
    course.term = self.textfieldTerm.text;
    course.instructor = self.textfieldInstructor.text;
    course.creditType = self.textfieldCreditType.text;
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    course.creditWeight = [f numberFromString:self.textfieldCreditWeight.text];
    
    if (!course.courseCode.length)
    {
        //Notify user of error
        TTGSnackbar* snackbar = [[TTGSnackbar alloc] initWithMessage:@"Invalid course code" duration:TTGSnackbarDurationShort];
        [snackbar show];
    }
    else if (!course.courseName.length)
    {
        //Notify user of error
        TTGSnackbar* snackbar = [[TTGSnackbar alloc] initWithMessage:@"Invalid course name" duration:TTGSnackbarDurationShort];
        [snackbar show];
    }
    else if (!course.term.length)
    {
        //Notify user of error
        TTGSnackbar* snackbar = [[TTGSnackbar alloc] initWithMessage:@"Invalid term" duration:TTGSnackbarDurationShort];
        [snackbar show];
    }
    else if (!course.instructor.length)
    {
        //Notify user of error
        TTGSnackbar* snackbar = [[TTGSnackbar alloc] initWithMessage:@"Invalid instructor" duration:TTGSnackbarDurationShort];
        [snackbar show];
    }
    else if (!course.creditType.length)
    {
        //Notify user of error
        TTGSnackbar* snackbar = [[TTGSnackbar alloc] initWithMessage:@"Invalid credit type" duration:TTGSnackbarDurationShort];
        [snackbar show];
    }
    else if (course.creditWeight == nil)
    {
        //Notify user of error
        TTGSnackbar* snackbar = [[TTGSnackbar alloc] initWithMessage:@"Invalid credit weight" duration:TTGSnackbarDurationShort];
        [snackbar show];
    }
    else if ([course isComplete])
    {
        NSDictionary *courseAsDictionary = [course toDictionary];
        
        //TODO Use user id and access control
        NSDictionary *childUpdates = @{key: courseAsDictionary};
        [coursesRef updateChildValues:childUpdates];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        //Notify user of error
        TTGSnackbar* snackbar = [[TTGSnackbar alloc] initWithMessage:@"Invalid course details" duration:TTGSnackbarDurationShort];
        [snackbar show];
    }
}
@end
