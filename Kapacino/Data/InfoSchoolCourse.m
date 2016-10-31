//
//  SchoolCourse.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-18.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "InfoSchoolCourse.h"

@implementation InfoSchoolCourse
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"uid" : @"COURSEID",
             @"name" : @"COURSENAME",
             @"subject" : @"COURSESUBJECT",
             @"code" : @"COURSECODE",
             @"oValue" : @"OVALUE",
             @"fValue" : @"FVALUE",
             @"schoolId" : @"SCHOOLID"
             };
}

-(NSString*) autocompleteString
{
    return [NSString stringWithFormat:@"%@ (%@)", self.name, self.code];
}
@end
