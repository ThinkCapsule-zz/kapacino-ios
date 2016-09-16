//
//  CFListingModel.m
//  Kapacino
//
//  Created by Alan Hsu on 2015-11-26.
//  Copyright © 2015 Alan Hsu. All rights reserved.
//

#import "CFEventModel.h"
#import "CFModelHelper.h"

@implementation CFEventModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"descriptionText": @"description",
             @"phoneNumber": @"phoneNumber",
             @"types": @"types",
             @"tags": @"tags",
             @"gallery": @"gallery",
             @"venue": @"venue",
             @"startTime": @"startTime",
             @"endTime": @"endTime",
             @"name": @"name",
             @"backgroundImageId": @"backgroundImage",
             };
}

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key {
    if ([key isEqualToString:@"backgroundImageId"]) {
        return [CFModelHelper getAssetDictionaryTransformer];
    }
    else if ([key isEqualToString:@"gallery"]) {
        return [CFModelHelper getAssetDictionaryArrayTransformer];
    }
    
    return nil;
}
@end
