//
//  CFArticleModel.m
//  Kapacino
//
//  Created by Alan Hsu on 2015-11-26.
//  Copyright © 2015 Alan Hsu. All rights reserved.
//

#import "CFArticleModel.h"

@implementation CFArticleModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"headline"    : @"headline",
             @"byline"      : @"byline",
             @"body"        : @"articleBody",
             @"publishDate" : @"publishDate",
             @"thumbnails"  : @"thumnails",
             @"tags"        : @"tags"
             };
}


@end
