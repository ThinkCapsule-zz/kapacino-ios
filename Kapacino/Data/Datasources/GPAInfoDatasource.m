//
//  GPAInfoDatasource.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-30.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "GPAInfoDatasource.h"
#import "InfoGPA.h"

@implementation GPAInfoDatasource
    -(NSString*) getDataFilename
    {
        return @"school/gpaList";
    }

    -(Class) getDataClass
    {
        return [InfoGPA class];
    }
@end
