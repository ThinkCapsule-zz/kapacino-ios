//
//  UIFont+KCAdditions.m
//  Kapacino
//
//  Created by Alan Hsu on 2016-01-24.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "UIFont+KCAdditions.h"

@implementation UIFont (KCAdditions)

#pragma mark - App Fonts

+ (UIFont *)kc_HeavyFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@".SFUIText-Heavy" size:size];
}

+ (UIFont *)kc_MediumFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@".SFUIText-Medium" size:size];
}

+ (UIFont *)kc_RegularFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@".SFUIText-Regular" size:size];
}

+ (UIFont *)kc_LightFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@".SFUIText-Light" size:size];
}

@end
