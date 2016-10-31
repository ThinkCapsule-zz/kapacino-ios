//
//  SchoolCourse.h
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-18.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "MLPAutoCompletionObject.h"

@interface InfoSchoolCourse : MTLModel <MTLJSONSerializing, MLPAutoCompletionObject>
    @property (strong, nonatomic) NSString* uid;
    @property (strong, nonatomic) NSString* schoolId;
    @property (strong, nonatomic) NSString* name;
    @property (strong, nonatomic) NSString* subject;
    @property (strong, nonatomic) NSString* code;
    @property (nonatomic) float oValue;
    @property (nonatomic) float fValue;
@end
