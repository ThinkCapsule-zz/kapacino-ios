//
//  User.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-16.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "User.h"

@implementation User
    - (instancetype)init:(FIRDataSnapshot*) snapshot
    {
        self = [super init];
        if (self) {
            NSDictionary* values = snapshot.value;
            self.key = snapshot.key;
            self.name = values[@"name"];
//            self.mark = values[@"mark"];
//            self.weight = values[@"weight"];
//            self.type = values[@"type"];
//            self.courseKey = values[@"courseKey"];
        }
        return self;
    }

    -(NSDictionary*) toDictionary
    {
        if (self.isComplete)
        {
            return @{
                     @"name": self.name,
//                     @"mark": self.mark,
//                     @"weight": self.weight,
//                     @"type": self.type,
//                     @"courseKey": self.courseKey
                     };
        }
        else
        {
            return nil;
        }
    }

    -(BOOL) isComplete
    {
        return self.name;
    }
@end
