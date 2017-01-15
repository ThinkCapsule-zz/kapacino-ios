//
//  MinorInfoDatasource.m
//  Kapacino
//
//  Created by Ivan Cheung on 2017-01-14.
//  Copyright © 2017 ThinkCapsule. All rights reserved.
//

#import "MinorInfoDatasource.h"
#import "InfoMinor.h"

@implementation MinorInfoDatasource
    -(NSString*) getDataFilename
    {
        return @"school/minor";
    }

    -(Class) getDataClass
    {
        return [InfoMinor class];
    }
@end
