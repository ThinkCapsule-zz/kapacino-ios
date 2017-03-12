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
            if (values != nil)
            {
                self.country = values[@"country"];
                self.hometown = values[@"hometown"];
                self.gender = values[@"gender"];
                self.schoolId = values[@"schoolId"];
                self.major = values[@"major"];
                self.minor = values[@"minor"];
                self.yearOfStudy = values[@"yearOfStudy"];
                self.universityEmail = values[@"universityEmail"];
                self.faculty = values[@"faculty"];
            }
//            self.locationCurrent = values[@"locationCurrent"];
        }
        return self;
    }

    -(NSDictionary*) toDictionary
    {
        if (self.isComplete)
        {
            NSMutableDictionary* info = [@{
                     @"country": self.country,
                     @"hometown": self.hometown,
                     @"schoolId": self.schoolId,
                     @"major": self.major,
                     @"minor": self.minor,
                     @"yearOfStudy": self.yearOfStudy,
                     @"universityEmail": self.universityEmail
                     } mutableCopy];
            
            if (self.gender)
            {
                info[@"gender"] = self.gender;
            }
                      
            return info;
        }
        else
        {
            return nil;
        }
    }

    -(BOOL) isComplete
    {
        BOOL isUniversityEmailValid = self.universityEmail && (self.universityEmail.length > 0);
        return self.country && self.hometown && self.yearOfStudy && self.schoolId && self.major && self.minor && isUniversityEmailValid;
    }
@end
