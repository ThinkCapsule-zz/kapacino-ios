//
//  CFModelHelper.h
//  Kapacino
//
//  Created by Ivan Cheung on 2016-09-06.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
@interface CFModelHelper : NSObject
    +(MTLValueTransformer*) getAssetDictionaryTransformer;
    +(MTLValueTransformer*) getAssetDictionaryArrayTransformer;
@end
