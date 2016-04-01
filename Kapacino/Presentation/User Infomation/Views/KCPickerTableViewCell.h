//
//  KCPickerTableViewCell.h
//  Kapacino
//
//  Created by Igor Czarev on 4/1/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KCPickerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (nonatomic) BOOL cellSelected;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLeftConstaint;

@end
