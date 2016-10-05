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

@interface KCGPACourseDetailTableViewController()
    @property (weak, nonatomic) IBOutlet UITextField *textfieldCreditWeight;
    @property (weak, nonatomic) IBOutlet UITextField *textfieldCreditType;
    @property (weak, nonatomic) IBOutlet UITextField *textfieldInstructor;
    @property (weak, nonatomic) IBOutlet UITextField *textfieldTerm;
    @property (weak, nonatomic) IBOutlet UITextField *textfieldCourseName;
    @property (weak, nonatomic) IBOutlet UITextField *textfieldCourseCode;
@end

@implementation KCGPACourseDetailTableViewController

- (IBAction)onDoneTapped:(id)sender {
    NSString *userID = [FIRAuth auth].currentUser.uid;
    
    FIRDatabaseReference* coursesRef = [[KCAPIClient sharedClient] coursesReference];

    NSString *key = [coursesRef childByAutoId].key;
    NSDictionary *course = @{
                               @"courseName": self.textfieldCourseName.text,
                               @"courseCode": self.textfieldCourseCode.text,
                               @"courseCode": self.textfieldCourseCode.text,
                               @"term": self.textfieldTerm.text,
                               @"instructor": self.textfieldInstructor.text,
                               @"creditType": self.textfieldCreditType.text,
                               @"creditWeight": self.textfieldCreditWeight.text,
                           };
    
    //TODO Use user id and access control
    NSDictionary *childUpdates = @{key: course};
    [coursesRef updateChildValues:childUpdates];
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
