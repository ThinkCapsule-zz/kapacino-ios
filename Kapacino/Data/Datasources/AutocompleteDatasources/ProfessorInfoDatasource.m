//
//  ProfessorInfoDatasource.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-20.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "ProfessorInfoDatasource.h"
#import "InfoProfessor.h"

@interface ProfessorInfoDatasource()
@end

@implementation ProfessorInfoDatasource
    -(NSString*) getDataFilename
    {
        return @"school/professorList";
    }

    -(Class) getDataClass
    {
        return [InfoProfessor class];
    }
@end
