//
//  KCDiscoverMenuCellTableViewCell.h
//  Kapacino
//
//  Created by Ivan Cheung on 2016-09-12.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KCDiscoverMenuCell : UITableViewCell
    @property (weak, nonatomic) IBOutlet UIImageView *imageViewIcon;
    @property (weak, nonatomic) IBOutlet UILabel *labelTitle;
    @property (weak, nonatomic) IBOutlet UILabel *labelSubtitle;
@end
