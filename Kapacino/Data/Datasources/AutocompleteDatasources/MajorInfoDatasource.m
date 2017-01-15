//
//  MajorInfoDatasource.m
//  Kapacino
//
//  Created by Ivan Cheung on 2017-01-14.
//  Copyright © 2017 ThinkCapsule. All rights reserved.
//

#import "MajorInfoDatasource.h"
#import "InfoMajor.h"

@implementation MajorInfoDatasource
    -(NSString*) getDataFilename
    {
        return @"school/major";
    }

    -(Class) getDataClass
    {
        return [InfoMajor class];
    }
@end
