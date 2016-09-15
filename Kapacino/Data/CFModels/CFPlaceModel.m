//
//  CFPlaceModel.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-09-15.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "CFPlaceModel.h"
#import "CFModelHelper.h"

@implementation CFPlaceModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{@"hours": @"hours",
             @"address": @"address",
             @"name": @"name",
             @"tags": @"tags",
             @"descriptionText": @"description",
             @"phoneNumber": @"phoneNumber",
             @"gallery": @"gallery",
             @"updatedAt": @"updatedAt",
             @"website": @"website",
             @"backgroundImageId": @"backgroundImage",
             @"type": @"type",
             @"isOnCampus": @"onCampus",
             @"isStudentCardAccepted": @"studentCard",
             @"creditCardsAccepted": @"creditCard",
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
