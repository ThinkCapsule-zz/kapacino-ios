//
//  UIColor+KCAdditions.m
//  Kapacino
//
//  Created by Alan Hsu on 2016-02-27.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "UIColor+KCAdditions.h"

@implementation UIColor (KCAdditions)

+ (UIColor *)kc_ApplicationColor {
    return [UIColor colorWithRed:(float)255/255 green:(float)125/255 blue:(float)125/255 alpha:1];
}

+ (UIColor *)kc_PrimaryTagColour {
    return [UIColor colorWithRed:(float)0/255 green:(float)153/255 blue:(float)153/255 alpha:1];
}

@end
