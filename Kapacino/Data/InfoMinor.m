//
//  InfoMinor.m
//  Kapacino
//
//  Created by Ivan Cheung on 2017-01-14.
//  Copyright © 2017 ThinkCapsule. All rights reserved.
//

#import "InfoMinor.h"

@implementation InfoMinor
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"uid" : @"minorID",
             @"schoolId" : @"schoolID",
             @"name" : @"minor",
             @"facultyId" : @"facultyID"
             };
}

-(NSString*) autocompleteString
{
    return [NSString stringWithFormat:@"%@", self.name];
}
@end
