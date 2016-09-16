//
//  CFDataSource.h
//  Kapacino
//
//  Created by Alan Hsu on 2015-11-26.
//  Copyright © 2015 Alan Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFDataSource : NSObject

+ (NSURL *)querySpace:(NSString *)space contentId:(NSString *)contentTypeId;

+ (NSURL *)querySpace:(NSString *)space forAsset:(NSString *)assetId;

+ (NSURL *)querySpace:(NSString *)space contentId:(NSString *)contentTypeId entryId:(NSString *) entryId;
@end
