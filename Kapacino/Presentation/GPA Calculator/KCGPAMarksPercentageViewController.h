//
//  KCGPAMarksPercentageViewController.h
//  Kapacino
//
//  Created by Ivan Cheung on 2016-11-04.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KCGPAMarksPercentageDelegate <NSObject>
    -(void) didPercentageChange:(float) percentage;
@end

@interface KCGPAMarksPercentageViewController : UIViewController
    @property float defaultPercentage;
    @property (weak) id<KCGPAMarksPercentageDelegate> delegate;
@end
