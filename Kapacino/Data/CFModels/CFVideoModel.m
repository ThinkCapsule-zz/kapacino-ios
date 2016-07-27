//
//  CFVideoModel.m
//  Kapacino
//
//  Created by Alan Hsu on 2015-11-26.
//  Copyright © 2015 Alan Hsu. All rights reserved.
//

#import "CFVideoModel.h"

@implementation CFVideoModel

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
