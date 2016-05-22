//
//  CFListingModel.m
//  Kapacino
//
//  Created by Alan Hsu on 2015-11-26.
//  Copyright © 2015 Alan Hsu. All rights reserved.
//

#import "CFListingModel.h"

@implementation CFListingModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"headline"    : @"headline",
             @"subtitle"    : @"subtitle",
             @"author"      : @"author",
             @"body"        : @"body",
             @"publishDate" : @"publishDate",
             @"thumbnails"  : @"thumbnails",
             @"tags"        : @"tags"
             };
}

@end
