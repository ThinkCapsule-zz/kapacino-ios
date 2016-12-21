//
//  User.h
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-16.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@import Firebase;

@interface User : NSObject
    @property(strong, nonatomic) NSString *key;
    @property(strong, nonatomic) NSString *name;

    @property(strong, nonatomic) NSString *email;    
    @property(strong, nonatomic) UserInfo *userInfo;

    - (instancetype)initWithUser:(FIRUser*) user;
    - (instancetype)initWithUser:(FIRUser*) user andInfo:(UserInfo*) userInfo;
    - (NSDictionary*) toDictionary;
    - (BOOL) isComplete;
@end
