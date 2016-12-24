//
//  KCUserInfoTableViewController.m
//  Kapacino
//
//  Created by Igor Czarev on 4/1/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCSchoolInformationTableViewController.h"
#import "KCSearchViewController.h"
//#import "UniversityInfoDatasource.h"
//#import "CityInfoDatasource.h"
#import "InfoSchool.h"

@interface KCSchoolInformationTableViewController ()
@property (strong, nonatomic) NSDictionary *countriesToCitiesMap;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;

@end

@implementation KCSchoolInformationTableViewController

NSString* const SEGUE_COUNTRY = @"showCountrySegue";
NSString* const SEGUE_HOMETOWN = @"showHometownSegue";
NSString* const SEGUE_FACULTY = @"showFacultySegue";

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
    
    [self loadCountries];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    KCUserInfoTableViewCell* cell = (KCUserInfoTableViewCell *) sender;
    
    if ([sender isKindOfClass:[KCUserInfoTableViewCell class]] && [segue.destinationViewController isKindOfClass:[KCPickerTableViewController class]]) {
        [self prepareForSegueWithPickerController:segue.destinationViewController cell:sender];
    }
    else if ([segue.identifier isEqualToString:SEGUE_COUNTRY]) {
        NSArray<NSString*>* countryNames = [self.countriesToCitiesMap allKeys];
        [self prepareForSegueWithSearchViewController:segue.destinationViewController withCategoryName:cell.title.text withItems:countryNames];
    }
    else if ([segue.identifier isEqualToString:SEGUE_HOMETOWN]) {
        NSArray* items = self.countriesToCitiesMap[self.user.userInfo.country];
        [self prepareForSegueWithSearchViewController:segue.destinationViewController withCategoryName:cell.title.text withItems:items];
    }
    else if ([segue.identifier isEqualToString:SEGUE_FACULTY]) {
//        NSArray* items = self.countriesToCitiesMap[self.user.userInfo.country];
//        [self prepareForSegueWithSearchViewController:segue.destinationViewController withCategoryName:cell.title.text withItems:items];
    }
}

- (void)loadCountries {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"countriesToCities" ofType:@"json"];
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUnicodeStringEncoding error:nil];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[myJSON dataUsingEncoding:NSUnicodeStringEncoding] options:kNilOptions error:nil];
    self.countriesToCitiesMap = json;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(KCUserInfoTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell.title.text isEqualToString:@"COUNTRY"]) {
        cell.subTitle.text = self.user.userInfo.country;
    } else if ([cell.title.text isEqualToString:@"HOMETOWN"]) {
        cell.subTitle.text = self.user.userInfo.hometown;
    } else if ([cell.title.text isEqualToString:@"FACULTY"]) {
        cell.subTitle.text = self.user.userInfo.faculty;
    } else if ([cell.title.text isEqualToString:@"UNIVERSITY EMAIL"]) {
        cell.subTitle.text = self.user.userInfo.universityEmail;
    }
}

- (void)prepareForSegueWithPickerController:(KCPickerTableViewController *)controller cell:(KCUserInfoTableViewCell *)cell {
    controller.delegate = self;
    controller.categoryName = cell.title.text;
}

- (void)prepareForSegueWithSearchViewController:(KCSearchViewController *)controller withCategoryName:(NSString *)categoryName withItems:(NSArray*)items{
    controller.delegate = self;
    controller.categoryName = categoryName;
    controller.items = items;
    controller.idKeyPath = nil;
    controller.nameKeyPath = nil;
}

- (void)pickerTableViewController:(KCPickerTableViewController *)controller didChangeUserInfo:(NSString *) info {
        
    [self.tableView reloadData];
}

- (void)searchViewController:(KCSearchViewController *)controller didChangeUserInfo:(NSString *) info {
    if ([controller.categoryName isEqualToString:@"COUNTRY"]) {
        self.user.userInfo.country = info;
    } else if ([controller.categoryName isEqualToString:@"HOMETOWN"]) {
        self.user.userInfo.hometown = info;
    } else if ([controller.categoryName isEqualToString:@"FACULTY"]) {
        self.user.userInfo.faculty = info;
    } else if ([controller.categoryName isEqualToString:@"UNIVERSITY EMAIL"]) {
        self.user.userInfo.universityEmail = info;
    }
    
    [self.tableView reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}

- (IBAction)onUniversityEmailChanged:(UITextField*) textField {
    self.user.userInfo.universityEmail = textField.text;
}
@end
