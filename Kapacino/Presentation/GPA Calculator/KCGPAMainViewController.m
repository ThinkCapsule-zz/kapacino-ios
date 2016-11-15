//
//  KCGPAMainViewController.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-08-08.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "KCGPAMainViewController.h"
#import "KCAPIClient.h"
#import "Course.h"
#import "Mark.h"
#import "KCGPACourseCell.h"
#import "KCGPAMarksViewController.h"
#import "DALabeledCircularProgressView.h"
#import "ProfessorInfoDatasource.h"
#import "InfoProfessor.h"
#import "InfoSchoolCourse.h"
#import "CourseInfoDatasource.h"
#import "InfoGPA.h"
#import "GPAInfoDatasource.h"

@import Firebase;
@import FirebaseDatabaseUI;

@interface KCGPAMainViewController () <UITableViewDataSource, UITableViewDelegate>
    @property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressViewGPAOverall;
    @property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressViewGPACurrent;
    @property (weak, nonatomic) IBOutlet UITableView *tableView;
    @property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControlGPA;

    @property (strong, nonatomic) NSMutableArray* courses;
    @property (strong, nonatomic) NSMutableDictionary<NSString*, NSMutableArray<Mark*>*> *courseToMarksDictionary;
    @property (strong, nonatomic) NSMutableDictionary<NSString*, NSNumber*> *courseToMarkDictionary;

    @property (weak, nonatomic) IBOutlet UILabel *labelCurrent;
    @property (weak, nonatomic) IBOutlet UILabel *labelOverall;

    @property (nonatomic) float progressCurrent;
    @property (nonatomic) float progressOverall;

    @property (nonatomic) float gpaMax;

    enum GPAMode
    {
        GPAMode_GPA,
        GPAMode_Percentage
    };

    @property (nonatomic) enum GPAMode mode;

    @property GPAInfoDatasource* gpaInfo;
    @property (strong, nonatomic) NSString* schoolId;
@end

@implementation KCGPAMainViewController

static NSString* kCellIdentifier = @"cell";
static NSString* kShowMarksSegue = @"showMarks";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.courses = [NSMutableArray array];
    [self setupTableView];
    
    self.schoolId = @"CA00011";
    [self processGPAInfo];
    
    self.progressViewGPACurrent.roundedCorners = YES;
    self.progressViewGPACurrent.trackTintColor = [UIColor lightGrayColor];
    self.progressViewGPACurrent.progressTintColor = [UIColor orangeColor];
    self.progressViewGPAOverall.roundedCorners = YES;
    self.progressViewGPAOverall.trackTintColor = [UIColor lightGrayColor];
    self.progressViewGPAOverall.progressTintColor = [UIColor redColor];
    
    self.progressCurrent = 0.5;
    self.progressOverall = 0.7;
    
    self.mode = GPAMode_GPA;
    
    //TODO fix this
    
    [self calculateGPA];
}

-(void) setMode:(enum GPAMode)mode
{
    _mode = mode;
    self.progressCurrent = self.progressCurrent;
    self.progressOverall = self.progressOverall;
    
    self.labelCurrent.text = mode == GPAMode_GPA ? @"Current GPA" : @"Current %";
    self.labelOverall.text = mode == GPAMode_GPA ? @"Overall GPA" : @"Overall %";
}

-(void) calculateGPA
{
    //Use cloud code to get mark?
    
    
    //Download all marks
    FIRDatabaseReference *courseRef = [[KCAPIClient sharedClient] coursesReference];
    FIRDatabaseReference *marksRef = [[KCAPIClient sharedClient] marksReference];
    
    //TODO: Add progress icon
    
    //TODO: Add constraint to only download marks for user
    
    //Download courses
    self.courseToMarksDictionary = [NSMutableDictionary dictionary];
    self.courseToMarkDictionary = [NSMutableDictionary dictionary];
    [courseRef observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        [self.courses removeAllObjects];
        for (FIRDataSnapshot* item in snapshot.children) {
            Course* course = [[Course alloc] init:item];
            [self.courses addObject:course];
            
            //Get marks for course
            FIRDatabaseQuery* query = [marksRef queryOrderedByChild:@"courseKey"];
            query = [query queryEqualToValue:course.key];
            [query observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull marksSnapshot) {
                 for (FIRDataSnapshot* markItem in marksSnapshot.children)
                 {
                     Mark* mark = [[Mark alloc] init:markItem];
                     
                     NSMutableArray* marks = self.courseToMarksDictionary[course.key];
                     if (!marks)
                     {
                         marks = [NSMutableArray<Mark*> array];
                     }
                     
                     [marks addObject:mark];
                     
                     self.courseToMarksDictionary[course.key] = marks;
                 }
                 
                 [self updateGPA];
                
                //TODO: Remove progress icon
                
             }];
        }
        
        //Reload table
        [self.tableView reloadData];
    }];
}

-(void) updateGPA
{
    float currentGPANumerator = 0;
    float overallGPANumerator = 0;
    float currentGPADenominator = 0;
    float overallGPADenominator = 0;
    for (Course* course in self.courses)
    {
        float markforCourse = 0;
        float sumOfWeights = 0;
        for (Mark* mark in self.courseToMarksDictionary[course.key])
        {
            markforCourse = markforCourse + ([mark.mark floatValue] * [mark.weight floatValue] / 100.0);
            sumOfWeights = sumOfWeights + [mark.weight floatValue];
        }
        
        markforCourse = sumOfWeights > 0 ? markforCourse/sumOfWeights * 100 : 0;
        
        self.courseToMarkDictionary[course.key] = @(markforCourse);
        
        float courseCredit = [course.creditWeight floatValue];
        float markforCourseAndCourseCredit = markforCourse * courseCredit;
        if ([self isCourseInCurrentTerm:course])
        {
            currentGPANumerator = currentGPANumerator + markforCourseAndCourseCredit;
            currentGPADenominator = currentGPADenominator + courseCredit;
        }
        
        overallGPANumerator = overallGPANumerator + markforCourseAndCourseCredit;
        overallGPADenominator = overallGPADenominator + courseCredit;
    }
    
    //Divide numerator by denominator
    self.progressCurrent = currentGPADenominator > 0 ? currentGPANumerator/currentGPADenominator : 0;
    self.progressOverall = overallGPADenominator > 0 ? overallGPANumerator/overallGPADenominator : 0;
    
    [self.tableView reloadData];
}

-(BOOL) isCourseInCurrentTerm:(Course*) course
{
    //Get current year
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    int year = (int) components.year;
    NSString* yearString = [NSString stringWithFormat:@"%d", year];
    return [course.term containsString:yearString];
}

-(void) setProgressCurrent:(float)progress
{
    _progressCurrent = progress;
    
    float progressModified = progress;
    
    if (self.mode == GPAMode_GPA)
    {
        progressModified = [self convertPercentageToGPA:progress];
        self.progressViewGPACurrent.progress = progressModified/self.gpaMax;
    }
    else
    {
        self.progressViewGPACurrent.progress = progressModified/100;
    }
    
    self.progressViewGPACurrent.progressLabel.text = [NSString stringWithFormat:@"%.1f", progressModified];
}

-(void) setProgressOverall:(float)progress
{
    _progressOverall = progress;
    
    float progressModified = progress;
    
    if (self.mode == GPAMode_GPA)
    {
        progressModified = [self convertPercentageToGPA:progress];
        self.progressViewGPAOverall.progress = progressModified/self.gpaMax;
    }
    else
    {
        self.progressViewGPAOverall.progress = progressModified/100;
    }
    
    self.progressViewGPAOverall.progressLabel.text = [NSString stringWithFormat:@"%.1f", progressModified];
}

-(void) processGPAInfo
{
    self.gpaInfo = [GPAInfoDatasource instance];
    
    NSArray* gpaInfoForSchool = [self.gpaInfo.data filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(InfoGPA* object, NSDictionary *bindings) {
        return [object.schoolId isEqualToString:self.schoolId];
    }]];
    
    self.gpaMax = 0;
    
    //Get percentages
    for (InfoGPA* info in gpaInfoForSchool)
    {
        self.gpaMax = fmax(self.gpaMax, info.oScale);
    }
    
    return;
}

-(float) convertPercentageToGPA:(float) percentage
{
    float percentageModified = percentage;

    NSArray* gpaInfoForSchool = [self.gpaInfo.data filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(InfoGPA* object, NSDictionary *bindings) {
        return [object.schoolId isEqualToString:self.schoolId];
    }]];
    
    //Get percentages
    for (InfoGPA* info in gpaInfoForSchool)
    {
        float progressCeil = ceilf(percentage);
        if (progressCeil >= info.min && progressCeil <= info.max)
        {
            percentageModified = info.oScale;
        }
    }
    
    return percentageModified;
}

-(void) setupTableView
{
    FIRDatabaseReference *ref = [[KCAPIClient sharedClient] coursesReference];
    
    [ref observeEventType:FIRDataEventTypeValue andPreviousSiblingKeyWithBlock:^(FIRDataSnapshot * _Nonnull snapshot, NSString * _Nullable prevKey) {
        [self.courses removeAllObjects];
        for (FIRDataSnapshot* item in snapshot.children) {
            Course* course = [[Course alloc] init:item];
            [self.courses addObject:course];
        }
        
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.courses.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KCGPACourseCell* cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    Course* course = self.courses[indexPath.row];
    
    InfoSchoolCourse* courseInfo = [[CourseInfoDatasource instance] getById:course.courseId];
    self.navigationItem.title = courseInfo.code;
    cell.labelCourseCode.text = courseInfo.code;
    
    //TODO Get professor name from id
    InfoProfessor* professor = [[ProfessorInfoDatasource instance] getById:course.instructorId];
    cell.labelInstructorName.text =  professor.fullName;;
    
    cell.labelTerm.text = course.term;
    
    NSNumber* courseMark = self.courseToMarkDictionary[course.key];
    
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.maximumFractionDigits = 0;
    cell.labelGPA.text = courseMark ? [formatter stringFromNumber:courseMark] : @"N/A";
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Course* course = self.courses[indexPath.row];
    [self performSegueWithIdentifier:kShowMarksSegue sender:course];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kShowMarksSegue])
    {
        KCGPAMarksViewController* vc = segue.destinationViewController;
        vc.course = sender;
    }
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    FIRDatabaseReference *coursesRef = [[KCAPIClient sharedClient] coursesReference];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //Get course at indexPath
        Course* course = self.courses[indexPath.row];
        
        [self.courses removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        //Remove the course
        [[coursesRef child:course.key] removeValue];
    }
}

- (IBAction)onSegmentGPAChanged:(UISegmentedControl*)sender {
    if (sender == self.segmentControlGPA)
    {
        self.mode = self.segmentControlGPA.selectedSegmentIndex == 0 ? GPAMode_GPA : GPAMode_Percentage;
    }
}

@end
