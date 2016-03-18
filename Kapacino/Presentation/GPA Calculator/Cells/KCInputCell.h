//
//  KCInputCell.h
//  Kapacino
//
//  Created by How Else on 3/18/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KCInputCellDelegate;

@interface KCInputCell : UITableViewCell

@property (nonatomic, weak) id<KCInputCellDelegate> delegate;

@property (nonatomic, strong) UITextField *textField;

@end

@protocol KCInputCellDelegate <NSObject>

@optional

- (void)inputCell:(KCInputCell *)cell didChangeTextFieldText:(NSString *)text;

@end
