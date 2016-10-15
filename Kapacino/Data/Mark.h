//
//  Mark.h
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-08.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Firebase;

@interface Mark : NSObject
    @property(strong, nonatomic) NSString *key;
    @property(strong, nonatomic) NSString *name;
    @property(strong, nonatomic) NSString *type;
    @property(strong, nonatomic) NSNumber *weight; //TODO Should be class
    @property(strong, nonatomic) NSNumber *mark;
    @property(strong, nonatomic) NSString *courseKey;

    -(instancetype)init:(FIRDataSnapshot*) snapshot;
    -(NSDictionary*) toDictionary;
    -(BOOL) isComplete;
@end
