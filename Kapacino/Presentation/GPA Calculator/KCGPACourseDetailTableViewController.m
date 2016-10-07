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


- (IBAction)onDoneTapped:(id)sender {
//    NSString *userID = [FIRAuth auth].currentUser.uid;
    
    FIRDatabaseReference* coursesRef = [[KCAPIClient sharedClient] coursesReference];

    NSString *key = [coursesRef childByAutoId].key;
    Course* course = [[Course alloc] init];
    course.courseCode = self.textfieldCourseCode.text;
    course.courseName = self.textfieldCourseCode.text;
    course.term = self.textfieldTerm.text;
    course.instructor = self.textfieldInstructor.text;
    course.creditType = self.textfieldCreditType.text;
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    course.creditWeight = [f numberFromString:self.textfieldCreditWeight.text];
    
    if ([course isComplete])
    {
        NSDictionary *courseAsDictionary = [course toDictionary];
        
        //TODO Use user id and access control
        NSDictionary *childUpdates = @{key: courseAsDictionary};
        [coursesRef updateChildValues:childUpdates];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
//        SnackbarController* snackbarController = [[SnackbarController alloc] init];
//        snackbarController.snack
    }
}
@end
