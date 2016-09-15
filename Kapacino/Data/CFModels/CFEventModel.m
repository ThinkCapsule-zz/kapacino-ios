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
             @"hours": @"hours",
             @"descriptionText"    : @"description",
             @"telephoneNumber"      : @"telephoneNumber",
             @"types"      : @"types",
             @"tags"      : @"tags",
             @"gallery"  : @"gallery",
             @"venue"  : @"venue"
             };
}

@end
