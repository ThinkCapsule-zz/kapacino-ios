//
//  CFModelFactory.m
//  Kapacino
//
//  Created by Alan Hsu on 2015-11-26.
//  Copyright © 2015 Alan Hsu. All rights reserved.
//

#import "CFModelFactory.h"
#import "CFArticleModel.h"
#import "CFBlogModel.h"
#import "CFVideoModel.h"
#import "CFListingModel.h"
#import "CFPlaceModel.h"

@implementation CFModelFactory

+ (NSArray *)parseResponseObjects:(NSArray *)response forType:(CFContentType)type {
    
    switch (type) {
        case CFContentType_Article:
            return [CFModelFactory parseArticleTypeResponse:response];
            
        case CFContentType_Blog:
            return [CFModelFactory parseBlogTypeResponse:response];
            
        case CFContentType_Video:
            return [CFModelFactory parseVideoTypeResponse:response];
            
        case CFContentType_Listing:
            return [CFModelFactory parseListingTypeResponse:response];
            
        case CFContentType_Places:
            return [CFModelFactory parsePlacesTypeResponse:response];
            
        default:
            return nil;
    }
}

#pragma mark - Private

+ (NSArray *)parseArticleTypeResponse:(NSArray*)responseObjects {
    
    NSMutableArray *objectList = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in responseObjects) {
        [objectList addObject:[MTLJSONAdapter modelOfClass:[CFArticleModel class] fromJSONDictionary:item[@"fields"] error:nil]];
    }
    
    return objectList;
}

+ (NSArray *)parseBlogTypeResponse:(NSArray*)responseObjects {
    NSMutableArray *objectList = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in responseObjects) {
        [objectList addObject:[MTLJSONAdapter modelOfClass:[CFBlogModel class] fromJSONDictionary:item[@"fields"] error:nil]];
    }
    
    return objectList;
}

+ (NSArray *)parseVideoTypeResponse:(NSArray*)responseObjects {
    NSMutableArray *objectList = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in responseObjects) {
        [objectList addObject:[MTLJSONAdapter modelOfClass:[CFVideoModel class] fromJSONDictionary:item[@"fields"] error:nil]];
    }
    
    return objectList;
}

+ (NSArray *)parseListingTypeResponse:(NSArray*)responseObjects {
    NSMutableArray *objectList = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in responseObjects) {
        [objectList addObject:[MTLJSONAdapter modelOfClass:[CFListingModel class] fromJSONDictionary:item[@"fields"] error:nil]];
    }
    
    return objectList;
}

+ (NSArray *)parsePlacesTypeResponse:(NSArray*)responseObjects {
    NSMutableArray *objectList = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in responseObjects) {
        [objectList addObject:[MTLJSONAdapter modelOfClass:[CFPlaceModel class] fromJSONDictionary:item[@"fields"] error:nil]];
    }
    
    return objectList;
}

@end
