//
//  UserInfo.h
//  Kapacino
//
//  Created by Ivan Cheung on 2016-12-11.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Firebase;

@interface UserInfo : NSObject
    //University\College id
    @property(strong, nonatomic) NSString *key;
    @property(strong, nonatomic) NSString *gender;
    @property(strong, nonatomic) NSString *hometown;
    @property(strong, nonatomic) NSString *country;
    @property(strong, nonatomic) NSString *locationCurrent;

    @property (strong, nonatomic) NSString* schoolId;
    @property (strong, nonatomic) NSString* major;
    @property (strong, nonatomic) NSString* minor;
    @property (strong, nonatomic) NSString* yearOfStudy; //This would change? Also, should be enum

    -(instancetype)init:(FIRDataSnapshot*) snapshot;
    -(NSDictionary*) toDictionary;
    -(BOOL) isComplete;
@end
