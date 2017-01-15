//
//  InfoMajor.m
//  Kapacino
//
//  Created by Ivan Cheung on 2017-01-14.
//  Copyright © 2017 ThinkCapsule. All rights reserved.
//

#import "InfoMajor.h"

@implementation InfoMajor
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"uid" : @"MajorID",
             @"schoolId" : @"SchoolID",
             @"name" : @"Major",
             @"facultyId" : @"FacultyID"
             };
}

-(NSString*) autocompleteString
{
    return [NSString stringWithFormat:@"%@", self.name];
}
@end
