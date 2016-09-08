//
//  CFListingModel.m
//  Kapacino
//
//  Created by Alan Hsu on 2015-11-26.
//  Copyright © 2015 Alan Hsu. All rights reserved.
//

#import "CFRestaurantModel.h"
#import "CFModelHelper.h"

@implementation CFRestaurantModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{@"hours": @"hours",
//             @"address": @"address",
             @"menu": @"menu",
             @"name": @"name",
             @"tags": @"tags",
             @"descriptionText": @"description",
             @"telephoneNumber": @"telephoneNumber",
             @"thumbnailIds": @"thumbnails",
             @"updatedAt": @"updatedAt",
             @"website": @"website",
             @"backgroundImageId": @"backgroundImage"
            };
}

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key {
    if ([key isEqualToString:@"backgroundImageId"]) {
        return [CFModelHelper getAssetDictionaryTransformer];
    }
    else if ([key isEqualToString:@"thumbnailIds"]) {
        return [CFModelHelper getAssetDictionaryArrayTransformer];
    }
    
    return nil;
}


@end
