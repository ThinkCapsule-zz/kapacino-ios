//
//  CourseInfoDatasource.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-30.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "CourseInfoDatasource.h"
#import "InfoSchoolCourse.h"

@implementation CourseInfoDatasource
    -(NSString*) getDataFilename
    {
        return @"school/courseList";
    }

    -(Class) getDataClass
    {
        return [InfoSchoolCourse class];
    }
@end
