//
//  CFClientHelper.h
//  Kapacino
//
//  Created by Alan Hsu on 2015-11-26.
//  Copyright © 2015 Alan Hsu. All rights reserved.
//

#import "CFContentType.h"
#import <Foundation/Foundation.h>

@interface CFClientHelper : NSObject

+ (NSString *) contentfulIdForContentType:(CFContentType)type;

@end
