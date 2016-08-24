//
//  CFListingModel.m
//  Kapacino
//
//  Created by Alan Hsu on 2015-11-26.
//  Copyright © 2015 Alan Hsu. All rights reserved.
//

#import "CFEventModel.h"

@implementation CFEventModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"listname"    : @"listname",
             @"location"    : @"location",
             @"telephoneNumber"      : @"telephoneNumber",
             @"thumbnails"  : @"thumbnails",
             };
}

@end
