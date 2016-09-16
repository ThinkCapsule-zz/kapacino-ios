//
//  CFListingModel.h
//  Kapacino
//
//  Created by Alan Hsu on 2015-11-26.
//  Copyright © 2015 Alan Hsu. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "CFPlaceModel.h"

@interface CFEventModel : MTLModel <MTLJSONSerializing>
@property (nonatomic, readonly) NSString  *name;
@property (nonatomic, readonly) NSString *address;
@property (nonatomic, readonly) NSString *phoneNumber;
@property (nonatomic, readonly) NSString *descriptionText;
@property (nonatomic, readonly) NSArray  *types;
@property (nonatomic, readonly) NSArray  *tags;
@property (nonatomic, readonly) NSArray  *gallery;
@property (nonatomic, readonly) NSDictionary  *venue;
@property (nonatomic, readonly) NSDate  *startTime;
@property (nonatomic, readonly) NSDate  *endTime;
@property (nonatomic, readonly) NSString  *backgroundImageId;

@property (nonatomic, readonly) NSString  *email;
@property (nonatomic, readonly) NSString  *website;
@property (nonatomic, readonly) NSArray  *crowd;
@property (nonatomic, readonly) NSArray  *dressCode;
@property (nonatomic, readonly) NSArray  *music;
@property (nonatomic, readonly) NSArray  *drinks;
@end

