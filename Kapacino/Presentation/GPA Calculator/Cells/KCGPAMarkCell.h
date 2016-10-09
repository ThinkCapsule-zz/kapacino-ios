//
//  KCGPAMarkCell.h
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-08.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KCGPAMarkCell : UITableViewCell
    @property (weak, nonatomic) IBOutlet UILabel *labelName;
    @property (weak, nonatomic) IBOutlet UILabel *labelType;
    @property (weak, nonatomic) IBOutlet UILabel *labelMark;

@end
