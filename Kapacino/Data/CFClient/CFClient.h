//
//  CFClient.h
//  Kapacino
//
//  Created by Alan Hsu on 2015-11-26.
//  Copyright © 2015 Alan Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CFContentType.h"

typedef void (^fetchContentCompletion)(NSArray *responseItems, NSError *error);
typedef void (^fetchAssetCompletion)(NSURL *imageURL, NSError *error);

@interface CFClient : NSObject

+ (void)fetchWithContentTypeId:(CFContentType)contentType completion:(fetchContentCompletion)completion;

+ (void)fetchAssetWithId:(NSString *)assetId completion:(fetchAssetCompletion)completion;

@end
