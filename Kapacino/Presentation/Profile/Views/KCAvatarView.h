//
//  KCAvatarView.h
//  Kapacino
//
//  Created by Igor Czarev on 3/23/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KCAvatarImageView.h"
#import "KCProfileLabel.h"

@interface KCAvatarView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (weak, nonatomic) IBOutlet KCAvatarImageView *avatarImageView;

@property (weak, nonatomic) IBOutlet KCProfileLabel *nameLabel;
@property (weak, nonatomic) IBOutlet KCProfileLabel *infoLabel;

@end
