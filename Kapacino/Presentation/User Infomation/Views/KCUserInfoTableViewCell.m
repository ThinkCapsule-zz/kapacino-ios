//
//  KCUserInfoTableViewCell.m
//  Kapacino
//
//  Created by Igor Czarev on 4/1/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCUserInfoTableViewCell.h"

@implementation KCUserInfoTableViewCell

+ (UINib *)nib {
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle bundleForClass:[self class]]];
}

@end
