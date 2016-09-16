//
//  CFDataSource.m
//  Kapacino
//
//  Created by Alan Hsu on 2015-11-26.
//  Copyright © 2015 Alan Hsu. All rights reserved.
//

/**
 Sample: https://preview.contentful.com/spaces/[SPACES_IDENTIFIER]/entries?access_token=[TOKEN_IDENTIFIER]&content_type=[CONTENT_TYPE_ID]
 */

#import "CFDataSource.h"
#import "CFDataSourceConstants.h"
#import "CFContentType.h"

@implementation CFDataSource

#pragma mark - Public

+ (NSURL *)querySpace:(NSString *)space contentId:(NSString *)contentTypeId {
    
    NSString* endpoint               = [NSString stringWithFormat:@"%@%@",[self baseEndpointURLForSpace:space],CFContentEntriesDir];
    NSURLQueryItem *tokenQuery       = [[NSURLQueryItem alloc] initWithName:CFContentTokenQuery value:[self token]];
    NSURLQueryItem *contentTypeQuery = [[NSURLQueryItem alloc] initWithName:CFContentTypeQuery value:contentTypeId];
    NSURLComponents *queryURL        = [[NSURLComponents alloc] initWithString:endpoint];

    queryURL.queryItems              = @[tokenQuery,contentTypeQuery];
    
    return [queryURL URL];
}

+ (NSURL *)querySpace:(NSString *)space contentId:(NSString *)contentTypeId entryId:(NSString *) entryId {
    
    NSString* endpoint               = [NSString stringWithFormat:@"%@%@/%@",[self baseEndpointURLForSpace:space],CFContentEntriesDir, entryId];
    NSURLQueryItem *tokenQuery       = [[NSURLQueryItem alloc] initWithName:CFContentTokenQuery value:[self token]];
    NSURLQueryItem *contentTypeQuery = [[NSURLQueryItem alloc] initWithName:CFContentTypeQuery value:contentTypeId];
    NSURLComponents *queryURL        = [[NSURLComponents alloc] initWithString:endpoint];
    
    queryURL.queryItems              = @[tokenQuery,contentTypeQuery];
    
    return [queryURL URL];
}

+ (NSURL *)querySpace:(NSString *)space forAsset:(NSString *)assetId {
    
    NSString* endpoint         = [NSString stringWithFormat:@"%@%@",[self baseEndpointURLForSpace:space],CFContentAssetsDir];
    endpoint                   = [endpoint stringByAppendingString:[NSString stringWithFormat:@"/%@",assetId]];
    NSURLQueryItem *tokenQuery = [[NSURLQueryItem alloc] initWithName:CFContentTokenQuery value:[self token]];
    NSURLComponents *queryURL  = [[NSURLComponents alloc] initWithString:endpoint];
    queryURL.queryItems        = @[tokenQuery];
    
    return [queryURL URL];
}

#pragma mark - Private

+ (NSString *)baseEndpointURLForSpace:(NSString *)spaceIdentifier{
    
#ifdef DEBUG
    return [NSString stringWithFormat:@"%@%@/%@",CFBasePreviewURL,CFContentSpacesDir,spaceIdentifier];
#endif
    return [NSString stringWithFormat:@"%@%@/%@",CFBaseProductionURL,CFContentSpacesDir,spaceIdentifier];
}

+ (NSString *)token{
    
#ifdef DEBUG
    return CFPreviewToken;
#endif
    return CFProductionToken;
}


@end
