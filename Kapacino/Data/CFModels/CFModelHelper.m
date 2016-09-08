//
//  CFModelHelper.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-09-06.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "CFModelHelper.h"

@implementation CFModelHelper
    +(MTLValueTransformer*) getAssetDictionaryTransformer
    {
        return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
            NSDictionary* dictionary = (NSDictionary*) value;
            NSAssert([dictionary isKindOfClass:NSDictionary.class], @"Expected a dictionary or an NSNull, got: %@", dictionary);
            
            NSString* assetId = dictionary[@"sys"][@"id"];
            return assetId;
        }];
    }

    +(MTLValueTransformer*) getAssetDictionaryArrayTransformer
    {
        return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
            NSArray* dictionaries = (NSArray*) value;
            
            NSAssert([dictionaries isKindOfClass:NSArray.class], @"Expected a array of dictionaries, got: %@", dictionaries);
            
            NSMutableArray* newDictionaries = [NSMutableArray arrayWithCapacity:dictionaries.count];
            for (NSDictionary* dictionary in dictionaries) {
                NSAssert([dictionary isKindOfClass:NSDictionary.class], @"Expected a dictionary or an NSNull, got: %@", dictionary);
                
                NSString* assetId = dictionary[@"sys"][@"id"];
                [newDictionaries addObject:assetId];
            }
            
            return newDictionaries;
        }];
    }
@end
