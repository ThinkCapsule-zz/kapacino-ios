//
//  UIColor+KCAdditions.m
//  Kapacino
//
//  Created by Alan Hsu on 2016-02-27.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "UIColor+KCAdditions.h"
#import <HexColors/HexColors.h>

@implementation UIColor (KCAdditions)

+ (UIColor *)kc_ApplicationColor {
    return [UIColor hx_colorWithHexString:@"FF7D7D"];
}

+ (UIColor *)kc_PrimaryTagColour {
    return [UIColor hx_colorWithHexString:@"009999"];
}

@end
