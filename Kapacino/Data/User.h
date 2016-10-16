//
//  User.h
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-16.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Firebase;

@interface User : NSObject
    @property(strong, nonatomic) NSString *key;
    @property(strong, nonatomic) NSString *name;
    @property(strong, nonatomic) NSString *gender;
    @property(strong, nonatomic) NSString *hometown;
    @property(strong, nonatomic) NSString *country;

    @property(strong, nonatomic) NSString *major;
    @property(strong, nonatomic) NSString *locationCurrent;
//    @property(strong, nonatomic) NSString *type;
//    @property(strong, nonatomic) NSNumber *weight; //TODO Should be class
//    @property(strong, nonatomic) NSNumber *mark;
//    @property(strong, nonatomic) NSString *courseKey;

    -(instancetype)init:(FIRDataSnapshot*) snapshot;
    -(NSDictionary*) toDictionary;
    -(BOOL) isComplete;
@end
