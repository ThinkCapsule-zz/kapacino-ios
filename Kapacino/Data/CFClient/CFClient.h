//
//  CFClient.h
//  Kapacino
//
//  Created by Alan Hsu on 2015-11-26.
//  Copyright © 2015 Alan Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CFContentType.h"


typedef void (^fetchContentCompletion)(NSDictionary *response, NSError *error);

@interface CFClient : NSObject

+ (void)fetchWithContentTypeId:(NSString*)contentTypeId completion:(fetchContentCompletion)completion;

@end
