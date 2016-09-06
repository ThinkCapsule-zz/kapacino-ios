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
             @"thumbnails": @"thumbnails",
             @"updatedAt": @"updatedAt",
             @"website": @"website"
         };
}

@end
