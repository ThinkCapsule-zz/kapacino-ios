//
//  CFModelFactory.h
//  Kapacino
//
//  Created by Alan Hsu on 2015-11-26.
//  Copyright © 2015 Alan Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CFContentType.h"

@interface CFModelFactory : NSObject

+ (NSArray *)parseResponseObjects:(NSArray *)response forType:(CFContentType)type;

@end
