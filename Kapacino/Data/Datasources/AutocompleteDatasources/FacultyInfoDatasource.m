//
//  FacultyInfoDatasource.m
//  Kapacino
//
//  Created by Ivan Cheung on 2017-01-15.
//  Copyright © 2017 ThinkCapsule. All rights reserved.
//

#import "FacultyInfoDatasource.h"
#import "InfoFaculty.h"

@implementation FacultyInfoDatasource
    -(NSString*) getDataFilename
    {
        return @"school/faculty";
    }

    -(Class) getDataClass
    {
        return [InfoFaculty class];
    }
@end
