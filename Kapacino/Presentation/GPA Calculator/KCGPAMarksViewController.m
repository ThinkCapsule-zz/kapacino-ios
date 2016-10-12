//
//  KCGPAMarksTableViewController.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-04.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "KCGPAMarksViewController.h"
#import "KCAPIClient.h"
#import "Mark.h"
#import "KCGPAMarkCell.h"
#import "KCGPACourseDetailTableViewController.h"
#import "KCGPAMarksDetailViewController.h"

@import Firebase;

@interface KCGPAMarksViewController ()
    @property (weak, nonatomic) IBOutlet UITableView *tableView;
    @property (strong, nonatomic) NSMutableArray* marks;
@end

@implementation KCGPAMarksViewController

static NSString* kShowEditCourse = @"showEditCourse";
static NSString* kShowEditMark = @"showEditMark";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.course.courseCode;
    self.marks = [NSMutableArray array];
    
    //Populate marks
    FIRDatabaseReference *ref = [[KCAPIClient sharedClient] marksReference];
    
    [ref observeEventType:FIRDataEventTypeValue andPreviousSiblingKeyWithBlock:^(FIRDataSnapshot * _Nonnull snapshot, NSString * _Nullable prevKey) {
        [self.marks removeAllObjects];
        for (FIRDataSnapshot* item in snapshot.children) {
            Mark* mark = [[Mark alloc] init:item];
            [self.marks addObject:mark];
        }
        
        [self.tableView reloadData];
    }];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onEditButtonTapped:(id)sender {
    [self performSegueWithIdentifier:kShowEditCourse sender:self.course];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kShowEditCourse])
    {
        KCGPACourseDetailTableViewController* vc = segue.destinationViewController;
        vc.course = sender;
    }
    else if ([segue.identifier isEqualToString:kShowEditMark])
    {
        KCGPAMarksDetailViewController* vc = segue.destinationViewController;
        
        if ([sender isKindOfClass:[Mark class]])
        {
            vc.mark = sender;
        }
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.marks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KCGPAMarkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    Mark* mark = self.marks[indexPath.row];
    cell.labelName.text = mark.name;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *markAsString = [formatter stringForObjectValue:mark.mark];
    cell.labelMark.text = markAsString;
    cell.labelType.text = mark.type;
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Mark* mark = self.marks[indexPath.row];
    [self performSegueWithIdentifier:kShowEditMark sender:mark];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
