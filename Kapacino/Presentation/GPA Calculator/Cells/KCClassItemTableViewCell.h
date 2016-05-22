//
//  KCClassItemTableViewCell.h
//  Kapacino
//
//  Created by Igor Czarev on 3/22/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KCClassItemTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemDescriptionLabel;

@end
