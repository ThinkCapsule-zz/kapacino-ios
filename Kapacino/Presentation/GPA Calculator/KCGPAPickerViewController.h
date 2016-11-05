//
//  KCGPAPickerViewController.h
//  Kapacino
//
//  Created by Ivan Cheung on 2016-11-04.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KCGPAPickerDelegate <NSObject>
    -(void) didPickerSelectString:(NSString *)string forSender:(id) sender;
@end

@interface KCGPAPickerViewController : UIViewController <UIPickerViewDelegate>
    @property (strong, nonatomic) NSArray* candidates;
    @property (nonatomic) int defaultIndex;
    @property (weak) id<KCGPAPickerDelegate> delegate;
    @property (weak) id sender;
@end
