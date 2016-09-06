//
//  CFListingModel.m
//  Kapacino
//
//  Created by Alan Hsu on 2015-11-26.
//  Copyright © 2015 Alan Hsu. All rights reserved.
//

#import "CFRestaurantModel.h"

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
        return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
            NSDictionary* dictionary = (NSDictionary*) value;
            NSAssert([dictionary isKindOfClass:NSDictionary.class], @"Expected a dictionary or an NSNull, got: %@", dictionary);
            return [[NSURL alloc] initWithString:dictionary[@"sys"][@"id"]];
        }];
    }
    else if ([key isEqualToString:@"imageIds"]) {
        return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
            NSArray* dictionaries = (NSArray*) value;

            NSAssert([dictionaries isKindOfClass:NSArray.class], @"Expected a array of dictionaries, got: %@", dictionaries);

            NSMutableArray* newDictionaries = [NSMutableArray arrayWithCapacity:dictionaries.count];
            for (NSDictionary* dictionary in dictionaries) {
                NSAssert([dictionary isKindOfClass:NSDictionary.class], @"Expected a dictionary or an NSNull, got: %@", dictionary);
                NSURL* assetURL = [[NSURL alloc] initWithString:dictionary[@"sys"][@"id"]];
                [newDictionaries addObject:assetURL];
            }
            
            return newDictionaries;
        }];
    }
    
    return nil;
}


@end
