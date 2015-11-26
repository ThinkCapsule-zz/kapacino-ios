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
#import <AFNetworking/AFHTTPRequestOperation.h>

@interface CFClient()

@end

@implementation CFClient

+ (void)fetchWithContentTypeId:(NSString*)contentTypeId completion:(fetchContentCompletion)completion {
    
    /** Prepare Request **/
    NSURL *baseURL                           = [CFDataSource querySpace:CFSpaceIdentifier contentId:contentTypeId];
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
