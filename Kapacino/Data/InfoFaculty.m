//
//  InfoFaculty.m
//  Kapacino
//
//  Created by Ivan Cheung on 2017-01-15.
//  Copyright © 2017 ThinkCapsule. All rights reserved.
//

#import "InfoFaculty.h"

@implementation InfoFaculty
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"uid" : @"facultyID",
             @"schoolId" : @"schoolID",
             @"name" : @"faculty"
             };
}

-(NSString*) autocompleteString
{
    return [NSString stringWithFormat:@"%@", self.name];
}
@end
