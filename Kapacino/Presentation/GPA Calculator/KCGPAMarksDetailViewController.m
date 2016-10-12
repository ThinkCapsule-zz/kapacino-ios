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
@import TTGSnackbar;

@import Firebase;

@interface KCGPAMarksDetailViewController()
    @property (weak, nonatomic) IBOutlet UITextField *textfieldName;
    @property (weak, nonatomic) IBOutlet UITextField *textfieldType;
    @property (weak, nonatomic) IBOutlet UITextField *textfieldWeight;
    @property (weak, nonatomic) IBOutlet UITextField *textfieldMark;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onDoneTapped:(id)sender {
    NSString *userID = [FIRAuth auth].currentUser.uid;
    
    FIRDatabaseReference* coursesRef = [[KCAPIClient sharedClient] marksReference];
    
    NSString *key = [coursesRef childByAutoId].key;
    Mark* mark = [[Mark alloc] init];
    mark.name = self.textfieldName.text;
    mark.type = self.textfieldType.text;
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    mark.weight = [f numberFromString:self.textfieldWeight.text];
    mark.mark = [f numberFromString:self.textfieldMark.text];
    
    if (!mark.name.length)
    {
        //Notify user of error
        TTGSnackbar* snackbar = [[TTGSnackbar alloc] initWithMessage:@"Invalid name" duration:TTGSnackbarDurationShort];
        [snackbar show];
    }
    else if (!mark.type.length)
    {
        //Notify user of error
        TTGSnackbar* snackbar = [[TTGSnackbar alloc] initWithMessage:@"Invalid type" duration:TTGSnackbarDurationShort];
        [snackbar show];
    }
    else if (mark.weight == nil)
    {
        //Notify user of error
        TTGSnackbar* snackbar = [[TTGSnackbar alloc] initWithMessage:@"Invalid weight" duration:TTGSnackbarDurationShort];
        [snackbar show];
    }
    else if (mark.mark == nil)
    {
        //Notify user of error
        TTGSnackbar* snackbar = [[TTGSnackbar alloc] initWithMessage:@"Invalid mark" duration:TTGSnackbarDurationShort];
        [snackbar show];
    }
    else
    {
        //TODO Use user id and access control
        NSDictionary *childUpdates = @{key: [mark toDictionary]};
        [coursesRef updateChildValues:childUpdates];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
