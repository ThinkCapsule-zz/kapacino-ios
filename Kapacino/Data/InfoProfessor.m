//
//  Professor.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-18.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "InfoProfessor.h"

@implementation InfoProfessor
    + (NSDictionary *)JSONKeyPathsByPropertyKey
    {
        return @{
                 @"uid" : @"PROFID",
                 @"fullName" : @"fullName",
                 @"firstName" : @"firstName",
                 @"lastName" : @"lastName",
                 @"schoolId" : @"SCHOOLID"
                 };
    }

    -(NSString*) autocompleteString
    {
        return self.fullName;
    }
@end
