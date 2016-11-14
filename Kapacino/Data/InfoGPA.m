//
//  InfoGPA.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-18.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "InfoGPA.h"

@implementation InfoGPA
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"uid" : @"GPAID",
             @"alpha" : @"Alpha",
             @"min" : @"Min",
             @"max" : @"Max",
             @"oScale" : @"O-Scale",
             @"fourScale" : @"4-Scale",
             @"schoolId" : @"schoolID"
             };
}
@end
