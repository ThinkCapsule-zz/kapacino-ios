//
//  KCSettingsViewController.m
//  Kapacino
//
//  Created by Alan Hsu on 2016-01-24.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCSettingsViewController.h"
#import <Firebase/Firebase.h>
#import <FBSDKLoginKit/FBSDKLoginManager.h>

@interface KCSettingsViewController()
    @property (strong, nonatomic) NSArray* settingOptions;
@end

@implementation KCSettingsViewController

    -(void)viewDidLoad {
        [super viewDidLoad];
        
        self.title = @"Settings";
        
        self.settingOptions = @[@"Privacy Statement", @"Logout"];
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

    -(void) logout
    {
        NSError* error;
        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
        [loginManager logOut];
        [[FIRAuth auth] signOut:&error];
        if (error != nil)
        {
            
        }
        else
        {
            
        }
    }

    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    {
//        NSString* setting = self.settingOptions[indexPath.row];
        
        switch (indexPath.row) {
            case 0:
                [self performSegueWithIdentifier:@"showPrivacyStatement" sender:nil];
                break;
            case 1:
                [self logout];
                break;
                
            default:
                break;
        }
    }
@end
