//
//  School.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-18.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "InfoSchool.h"

@implementation InfoSchool
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"uid" : @"SchoolID",
             @"name" : @"Name",
             @"location" : @"Location"
             };
}

-(NSString*) autocompleteString
{
    return [NSString stringWithFormat:@"%@ (%@)", self.name, self.location];
}
@end
