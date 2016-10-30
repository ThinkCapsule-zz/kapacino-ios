//
//  UniversityInfoDatasource.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-30.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "UniversityInfoDatasource.h"
#import "InfoSchool.h"

@implementation UniversityInfoDatasource
    -(NSString*) getDataFilename
    {
        return @"school/universityList";
    }

    -(Class) getDataClass
    {
        return [InfoSchool class];
    }
@end
