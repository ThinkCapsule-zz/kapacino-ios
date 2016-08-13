//
//  KCSettingsViewController.m
//  Kapacino
//
//  Created by Alan Hsu on 2016-01-24.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCSettingsViewController.h"

@interface KCSettingsViewController()
    @property (strong, nonatomic) NSArray* settingOptions;
@end

@implementation KCSettingsViewController

    -(void)viewDidLoad {
        [super viewDidLoad];
        
        self.title = @"Settings";
        
        self.settingOptions = @[@"Privacy Statement", @"Setting2"];
    }

    - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;              // Default is 1 if not
    {
        return 1;
    }

    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        return self.settingOptions.count;
    }

    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        NSString* setting = self.settingOptions[indexPath.row];
        cell.textLabel.text = setting;
        
        return cell;
    }

    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    {
        NSString* setting = self.settingOptions[indexPath.row];
//        switch (setting) {
//            case "Privacy Statement":
                [self performSegueWithIdentifier:@"showPrivacyStatement" sender:nil];
//                break;
//                
//            default:
//                break;
//        }
    }
@end
