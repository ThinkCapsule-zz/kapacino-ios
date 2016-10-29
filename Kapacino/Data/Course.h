//
//  Course.h
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-04.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Firebase;

@interface Course : NSObject
    @property(strong, nonatomic) NSString *key;
    @property(strong, nonatomic) NSString *courseCode;
    @property(strong, nonatomic) NSString *courseName;
    @property(strong, nonatomic) NSString *term; //TODO Should be class
    @property(strong, nonatomic) NSString *instructorId;
    @property(strong, nonatomic) NSString *creditType; //TODO Should be enum
    @property(nonatomic) NSNumber* creditWeight;

    -(instancetype)init:(FIRDataSnapshot*) snapshot;
    -(NSDictionary*) toDictionary;
    -(BOOL) isComplete;
@end
