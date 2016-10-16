//
//  KCGPAMainViewController.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-08-08.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "KCGPAMainViewController.h"
#import "KCAPIClient.h"
#import "CourseDataSource.h"
#import "Course.h"
#import "Mark.h"
#import "KCGPACourseCell.h"
#import "KCGPAMarksViewController.h"
#import "DALabeledCircularProgressView.h"

@import Firebase;
@import FirebaseDatabaseUI;

@interface KCGPAMainViewController () <UITableViewDataSource, UITableViewDelegate>
    @property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressViewGPAOverall;
    @property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressViewGPACurrent;
    @property (weak, nonatomic) IBOutlet UITableView *tableView;
    @property (strong, nonatomic) NSMutableArray* courses;

    @property (nonatomic) float progressCurrent;
    @property (nonatomic) float progressOverall;
@end

@implementation KCGPAMainViewController

static NSString* kCellIdentifier = @"cell";
static NSString* kShowMarksSegue = @"showMarks";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.courses = [NSMutableArray array];
    [self setupTableView];
    
    self.progressViewGPACurrent.roundedCorners = YES;
    self.progressViewGPACurrent.trackTintColor = [UIColor lightGrayColor];
    self.progressViewGPACurrent.progressTintColor = [UIColor orangeColor];
    self.progressViewGPAOverall.roundedCorners = YES;
    self.progressViewGPAOverall.trackTintColor = [UIColor lightGrayColor];
    self.progressViewGPAOverall.progressTintColor = [UIColor redColor];
    
    self.progressCurrent = 0.5;
    self.progressOverall = 0.7;
}

-(void) calculateGPA
{
    //Use cloud code to get mark?
    
    
    //Download all marks
    FIRDatabaseReference *courseRef = [[KCAPIClient sharedClient] coursesReference];
    FIRDatabaseReference *markRef = [[KCAPIClient sharedClient] coursesReference];
    
    //TODO: Add progress icon
    
    //TODO: Download courses
    
    //TODO: Add constraint to only download marks for user
    
    //Download courses
    NSDictionary<Course*, NSMutableArray<Mark*>*> *courseToMarkDictionary = [NSMutableDictionary dictionary];
    [courseRef observeEventType:FIRDataEventTypeValue andPreviousSiblingKeyWithBlock:^(FIRDataSnapshot * _Nonnull snapshot, NSString * _Nullable prevKey) {
        [self.courses removeAllObjects];
        for (FIRDataSnapshot* item in snapshot.children) {
            Course* course = [[Course alloc] init:item];
            [self.courses addObject:course];
            
            //Get marks for course
            [[markRef queryEqualToValue:course.key]
             observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull marksSnapshot) {
                 for (FIRDataSnapshot* markItem in marksSnapshot.children)
                 {
                     Mark* mark = [[Mark alloc] init:markItem];
                     
                     NSMutableArray* marks = courseToMarkDictionary[course];
                     if (!marks)
                     {
                         marks = [NSMutableArray<Mark*> array];
                     }
                     
                     [marks addObject:mark];
                 }
             }];
        }
        
        //TODO: Remove progress icon
        
        //TODO: Calculate GPA
//        NSNumber* numberOfCourses = self.courses.count;
//        NSNumber* gpa = sum(marks% * credits)/numberOfCourses;
        
        //Reload table
        [self.tableView reloadData];
    }];
}

-(void) setProgressCurrent:(float)progress
{
    self.progressViewGPACurrent.progress = progress;
    self.progressViewGPACurrent.progressLabel.text = [NSString stringWithFormat:@"%.2f", progress];
}

-(void) setProgressOverall:(float)progress
{
    self.progressViewGPAOverall.progress = progress;
    self.progressViewGPAOverall.progressLabel.text = [NSString stringWithFormat:@"%.2f", progress];
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
    
//    self.dataSource = [[CourseDataSource alloc] initWithRef:ref
//                                                 modelClass:[Course class]
//                                                   nibNamed:@"KCGPACourseCell"
//                                        cellReuseIdentifier:@"cell"
//                                                       view:self.tableView];
//    [self.tableView registerClass:[KCGPACourseCell class] forCellReuseIdentifier:@"cell"];
    
//    [self.dataSource populateCellWithBlock:^void(KCGPACourseCell * cell, Course * course) {
//        /* Populate cell with contents of the snapshot */
//        cell.labelCourseCode.text = course.courseCode;
//        cell.labelInstructorName.text = course.instructor;
//        cell.labelTerm.text = course.term;
//        cell.labelGPA.text = @"N/A";
////        cell.textLabel.text = course.courseCode;
//     }];
}

- (void) save
{
    NSString *userID = [KCAPIClient sharedClient].currentUserID ;
//    [self.userInfo setValue:@"YES" forKey:@"complete"];
//    [[KCAPIClient sharedClient] updateUserWithID:userID userInfo:nil success:^(Firebase *userRef) {
////        KCLoadingPage *loadingPageViewConrtoller = [[UIStoryboard storyboardWithName:@"User Information" bundle:nil] instantiateViewControllerWithIdentifier:@"KCLoadingPage"];
////        [self.navigationController setViewControllers:@[loadingPageViewConrtoller] animated:YES];
//    } failure:nil];
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
    
    cell.labelCourseCode.text = course.courseCode;
    cell.labelInstructorName.text = course.instructor;
    cell.labelTerm.text = course.term;
    cell.labelGPA.text = @"N/A";
    
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

@end
