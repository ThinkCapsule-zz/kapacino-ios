//
//  InfoMinor.h
//  Kapacino
//
//  Created by Ivan Cheung on 2017-01-14.
//  Copyright © 2017 ThinkCapsule. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface InfoMinor : MTLModel <MTLJSONSerializing>
@property (strong, nonatomic) NSString* uid;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* schoolId;
@property (strong, nonatomic) NSString* facultyId;
@end
