//
//  KCUserInfoTableViewController.m
//  Kapacino
//
//  Created by Igor Czarev on 4/1/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCUserInfoTableViewController.h"
#import "KCSearchViewController.h"
#import "UniversityInfoDatasource.h"
#import "MajorInfoDatasource.h"
#import "MinorInfoDatasource.h"
#import "InfoSchool.h"

@interface KCUserInfoTableViewController ()

@property (weak, nonatomic) IBOutlet UILabel *headerLabel;

@end

@implementation KCUserInfoTableViewController

NSString* const SEGUE_SCHOOL = @"showSchoolsSegue";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *userName = self.user.name;
    if (userName) {
        NSString *firstName = [[userName componentsSeparatedByString:@" "] firstObject];
        self.headerLabel.text = [NSString stringWithFormat:@"Hey, %@",firstName ];
        self.headerLabel.adjustsFontSizeToFitWidth = YES;
        self.headerLabel.minimumScaleFactor = 0.5;
    } else {
        self.headerLabel.text = @"Hello";
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    KCUserInfoTableViewCell* cell = (KCUserInfoTableViewCell *) sender;
    
    if ([sender isKindOfClass:[KCUserInfoTableViewCell class]] && [segue.destinationViewController isKindOfClass:[KCPickerTableViewController class]]) {
        [self prepareForSegueWithPickerController:segue.destinationViewController cell:sender];
    } else if ([segue.identifier isEqualToString:SEGUE_SCHOOL]) {
        NSArray* items = [[UniversityInfoDatasource sharedInstance] data];
        [self prepareForSegueWithSearchViewController:segue.destinationViewController withCategoryName:cell.title.text withItems:items];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(KCUserInfoTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([cell.title.text isEqualToString:@"Name*"]) {
//        cell.subTitle.text = self.user.name;
//    } else
    if ([cell.title.text isEqualToString:@"UNIVERSITY"]) {
        //Get university from id
        InfoSchool* schoolInfo = [[UniversityInfoDatasource sharedInstance] getById:self.user.userInfo.schoolId];
//        NSLog(@"schoolName: %@", schoolName);
        cell.subTitle.text = schoolInfo.name;
    } else if ([cell.title.text isEqualToString:@"MAJOR"]) {
        cell.subTitle.text = self.user.userInfo.major;
    } else if ([cell.title.text isEqualToString:@"MINOR"]) {
        cell.subTitle.text = self.user.userInfo.minor;
    } else if ([cell.title.text isEqualToString:@"YEAR OF STUDY"]) {
        cell.subTitle.text = self.user.userInfo.yearOfStudy;
    }
}

- (void)prepareForSegueWithPickerController:(KCPickerTableViewController *)controller cell:(KCUserInfoTableViewCell *)cell {
    controller.delegate = self;
    controller.categoryName = cell.title.text;
    
    if ([cell.title.text isEqualToString:@"MAJOR"]) {
        NSArray *items = [[MajorInfoDatasource sharedInstance] data];
        NSArray *objectsForSchool;
        if (self.user.userInfo.schoolId)
        {
            NSPredicate* predicate = [NSPredicate predicateWithFormat:@"%K = %@", @"schoolId", self.user.userInfo.schoolId];
            objectsForSchool = [items filteredArrayUsingPredicate:predicate];
        }
        else
        {
            objectsForSchool = items;
        }
        
        //Get names
        NSArray* names = [objectsForSchool valueForKey:@"name"];
        
        controller.items = names;
    } else if ([cell.title.text isEqualToString:@"MINOR"]) {
        NSArray *items = [[MinorInfoDatasource sharedInstance] data];
        NSArray *objectsForSchool;
        if (self.user.userInfo.schoolId)
        {
            NSPredicate* predicate = [NSPredicate predicateWithFormat:@"%K = %@", @"schoolId", self.user.userInfo.schoolId];
            objectsForSchool = [items filteredArrayUsingPredicate:predicate];
        }
        else
        {
            objectsForSchool = items;
        }
        
        //Get names
        NSArray* names = [objectsForSchool valueForKey:@"name"];
        
        controller.items = names;
    } else if ([cell.title.text isEqualToString:@"YEAR OF STUDY"]) {
        NSArray *items = @[ @"Freshman (First Year)", @"Sophomore (Second Year)", @"Senior (Third Year)", @"Senior (Fourth Year)" ];
        controller.items = items;
    }
}

- (void)prepareForSegueWithSearchViewController:(KCSearchViewController *)controller withCategoryName:(NSString *)categoryName withItems:(NSArray*)items{
    controller.delegate = self;
    controller.categoryName = categoryName;
    controller.items = items;
    controller.idKeyPath = @"uid";
    controller.nameKeyPath = @"name";
}

- (void)pickerTableViewController:(KCPickerTableViewController *)controller didChangeUserInfo:(NSString *) info {
    if ([controller.categoryName isEqualToString:@"MAJOR"])
    {
        self.user.userInfo.major = info;
    }
    else if ([controller.categoryName isEqualToString:@"MINOR"])
    {
        self.user.userInfo.minor = info;
    }
    else if ([controller.categoryName isEqualToString:@"YEAR OF STUDY"])
    {
        self.user.userInfo.yearOfStudy = info;
    }
    
    [self.tableView reloadData];
}

- (void)searchViewController:(KCSearchViewController *)controller didChangeUserInfo:(NSString *) info {
    if ([controller.categoryName isEqualToString:@"UNIVERSITY"])
    {
        //If the school changed reset major and minor
        if (self.user.userInfo.schoolId != info)
        {
            self.user.userInfo.major = nil;
            self.user.userInfo.minor = nil;
            self.user.userInfo.faculty = nil;
        }
        
        self.user.userInfo.schoolId = info;
        
        [self.tableView reloadData];
    }
    
    [self.tableView reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}

- (IBAction)onUniversityEmailChanged:(UITextField*)sender {
    self.user.email = sender.text;
}

@end
