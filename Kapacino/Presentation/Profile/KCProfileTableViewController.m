//
//  KCProfileTableViewController.m
//  Kapacino
//
//  Created by Igor Czarev on 3/24/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCProfileTableViewController.h"

@interface KCProfileTableViewController ()

@end

@implementation KCProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.avatarView.backgroundImageView.image = [UIImage imageNamed:@"profileImage"];
    self.avatarView.nameLabel.text = @"Test User";
    self.avatarView.infoLabel.text = @"User Info";
    self.avatarView.avatarImageView.image = [UIImage imageNamed:@"profileImage"];
    
    self.emailLabel.text = @"qwerty@example.com";
    self.genderLabel.text = @"male";
    self.facultyLabel.text = @"Engineering";
    self.majorLabel.text = @"Mechatronics";
    self.classOfLabel.text = @"2017";
    self.cityLabel.text = @"Toronto";
}

@end
