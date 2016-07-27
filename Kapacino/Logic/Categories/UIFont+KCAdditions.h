//
//  UIFont+KCAdditions.h
//  Kapacino
//
//  Created by Alan Hsu on 2016-01-24.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (KCAdditions)

+ (UIFont *)kc_HeavyFontWithSize:(CGFloat)size;
+ (UIFont *)kc_MediumFontWithSize:(CGFloat)size;
+ (UIFont *)kc_RegularFontWithSize:(CGFloat)size;
+ (UIFont *)kc_LightFontWithSize:(CGFloat)size;

@end
