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
        
        //Update courses
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
