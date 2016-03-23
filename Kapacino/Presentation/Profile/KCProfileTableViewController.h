//
//  KCProfileTableViewController.h
//  Kapacino
//
//  Created by Igor Czarev on 3/24/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KCAvatarView.h"

@interface KCProfileTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet KCAvatarView *avatarView;

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *facultyLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
@property (weak, nonatomic) IBOutlet UILabel *classOfLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;

@end
