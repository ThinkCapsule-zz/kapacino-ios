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
#import "CFEventModel.h"

@implementation CFModelFactory

+ (NSArray *)parseResponseObjects:(NSArray *)response forType:(CFContentType)type {
    
    switch (type) {
        case CFContentType_Article:
            return [CFModelFactory parseResponseWithObjects:response class:[CFArticleModel class]];
            
        case CFContentType_Blog:
            return [CFModelFactory parseResponseWithObjects:response class:[CFBlogModel class]];
            
        case CFContentType_Video:
            return [CFModelFactory parseResponseWithObjects:response class:[CFVideoModel class]];
            
        case CFContentType_Listing:
            return [CFModelFactory parseResponseWithObjects:response class:[CFListingModel class]];
        
        case CFContentType_Events:
            return [CFModelFactory parseResponseWithObjects:response class:[CFEventModel class]];
            
        default:
            return nil;
    }
}

#pragma mark - Private

+ (NSArray *)parseResponseWithObjects:(NSArray*)responseObjects class:(Class)class{
    
    NSMutableArray *objectList = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in responseObjects) {
        
        [objectList addObject:[MTLJSONAdapter modelOfClass:class fromJSONDictionary:item[@"fields"] error:nil]];
    }
    
    return objectList;
}

@end
