//
//  CFClient.m
//  Kapacino
//
//  Created by Alan Hsu on 2015-11-26.
//  Copyright © 2015 Alan Hsu. All rights reserved.
//

#import "CFClient.h"
#import "CFDataSource.h"
#import "CFDataSourceConstants.h"
#import "CFClientHelper.h"

#import <AFNetworking/AFHTTPRequestOperation.h>

@interface CFClient()

@end

@implementation CFClient

+ (void)fetchWithContentTypeId:(CFContentType)contentType completion:(fetchContentCompletion)completion {
    
    /** Prepare Request **/
    NSURL *baseURL                           = [CFDataSource querySpace:CFSpaceIdentifier contentId:[CFClientHelper contentfulIdForContentType:contentType]];
    NSURLRequest *request                    = [NSURLRequest requestWithURL:baseURL];
    AFHTTPRequestOperation* requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    /** Send Request **/
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
       
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSArray *items = response[@"items"];
    
        completion(items, nil);
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        completion(nil, error);
        
    }];
    
    [requestOperation start];
}

+ (void)fetchWithContentTypeId:(CFContentType)contentType andEntryId:(NSString*)entryId completion:(fetchAssetCompletion)completion {
    /** Prepare Request **/
    NSURL *baseURL                           = [CFDataSource querySpace:CFSpaceIdentifier contentId:[CFClientHelper contentfulIdForContentType:contentType] entryId:entryId];
    NSURLRequest *request                    = [NSURLRequest requestWithURL:baseURL];
    AFHTTPRequestOperation* requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    /** Send Request **/
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        completion(response, nil);
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        completion(nil, error);
        
    }];
    
    [requestOperation start];
}

//TODO Might want to cache this
+ (void)fetchImageWithId:(NSString *)assetId completion:(fetchImageCompletion)completion {
    return [self fetchAssetWithId:assetId completion:^(NSDictionary *result, NSError *error) {
        NSString *imageURL = result[@"fields"][@"file"][@"url"];
        imageURL = [NSString stringWithFormat:@"http:%@",imageURL];
        
        completion([[NSURL alloc] initWithString:imageURL], nil);
    }];
}

+ (void)fetchAssetWithId:(NSString *)assetId completion:(fetchAssetCompletion)completion {
    NSAssert(assetId != nil, @"Asset id must not be null.");
    
    /** Prepare Request **/
    NSURL *baseURL                           = [CFDataSource querySpace:CFSpaceIdentifier forAsset:assetId];
    NSURLRequest *request                    = [NSURLRequest requestWithURL:baseURL];
    AFHTTPRequestOperation* requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    /** Send Request **/
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        completion(response, nil);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        completion(nil, error);
    }];
    
    [requestOperation start];    
}


@end
