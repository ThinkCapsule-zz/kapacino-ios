//
//  UserInfo.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-12-11.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
    - (instancetype)init:(FIRDataSnapshot*) snapshot
    {
        self = [super init];
        if (self) {
            NSDictionary* values = snapshot.value;
            self.key = snapshot.key;
            self.country = values[@"country"];
            self.hometown = values[@"hometown"];
            self.gender = values[@"gender"];
            self.schoolId = values[@"schoolId"];
            self.major = values[@"major"];
            self.minor = values[@"minor"];
            self.yearOfStudy = values[@"yearOfStudy"];
            self.locationCurrent = values[@"locationCurrent"];
        }
        return self;
    }

    -(NSDictionary*) toDictionary
    {
        if (self.isComplete)
        {
            return @{
                     @"locationCurrent": self.locationCurrent,
                     @"country": self.country,
                     @"hometown": self.hometown,
                     @"gender": self.gender,
                     @"schoolId": self.schoolId,
                     @"major": self.major,
                     @"minor": self.minor,
                     @"yearOfStudy": self.yearOfStudy,
                     };
        }
        else
        {
            return nil;
        }
    }

    -(BOOL) isComplete
    {
        return self.yearOfStudy && self.schoolId && self.major && self.minor;
    }
@end
