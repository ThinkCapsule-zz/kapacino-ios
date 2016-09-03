//
//  CFClientHelper.m
//  Kapacino
//
//  Created by Alan Hsu on 2015-11-26.
//  Copyright © 2015 Alan Hsu. All rights reserved.
//

#import "CFClientHelper.h"
#import "CFDataSourceConstants.h"

@implementation CFClientHelper

+ (NSString *) contentfulIdForContentType:(CFContentType)type {
    
    NSDictionary* contentIdMap = @{@(CFContentType_Article): CFArticleTypeIdentifier,
                                   @(CFContentType_Blog): CFBlogTypeIdentifier,
                                   @(CFContentType_Video): CFVideoTypeIdentifier,
                                   @(CFContentType_Listing): CFListingTypeIdentifier,
                                   @(CFContentType_Place): CFPlaceTypeIdentifier,
                                   @(CFContentType_Event): CFEventTypeIdentifier,
                                   @(CFContentType_Restaurant): CFRestaurantTypeIdentifier};

    return [contentIdMap objectForKey:@(type)];
}

@end
