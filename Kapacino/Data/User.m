//
//  User.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-16.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "User.h"

@implementation User
    - (instancetype)initWithUser:(FIRUser*) user
    {
        self = [super init];
        if (self) {
            self.key = user.uid;
            self.name = user.displayName;
            self.email = user.email;
        }
        return self;
    }

    - (instancetype)initWithUser:(FIRUser*) user andInfo:(UserInfo*) userInfo
    {
        self = [super init];
        if (self) {
            self.key = user.uid;
            self.name = user.displayName;
            self.email = user.email;
            self.userInfo = userInfo;
        }
        return self;
    }

    -(NSDictionary*) toDictionary
    {
        if (self.isComplete)
        {
            return @{
                     @"name": self.name,
                     @"email": self.email
                 };
        }
        else
        {
            return nil;
        }
    }

    -(BOOL) isComplete
    {
        return self.name && self.email && [self.userInfo isComplete];
    }
@end
