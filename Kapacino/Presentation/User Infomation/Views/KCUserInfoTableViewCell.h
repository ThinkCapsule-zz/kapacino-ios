//
//  KCUserInfoTableViewCell.h
//  Kapacino
//
//  Created by Igor Czarev on 4/1/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface KCUserInfoTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UITextField *subTitle;
@property (strong, nonatomic) User *user;

+ (UINib *)nib;

@end
