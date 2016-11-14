//
//  InfoGPA.h
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-18.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface InfoGPA : MTLModel <MTLJSONSerializing>
    @property (strong, nonatomic) NSString* uid;
    @property (strong, nonatomic) NSString* schoolId;
    @property (strong, nonatomic) NSString* alpha;
    @property (nonatomic) int min;
    @property (nonatomic) int max;
    @property (nonatomic) float fourScale;
    @property (nonatomic) float oScale;
@end
