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

@property (nonatomic, readonly) NSString *listname;
@property (nonatomic, readonly) NSString *location;
@property (nonatomic, readonly) NSString *telephoneNumber;
@property (nonatomic, readonly) NSString *descriptionText;
@property (nonatomic, readonly) NSArray  *thumbnails;
@property (nonatomic, readonly) NSArray  *types;
@property (nonatomic, readonly) NSArray  *tags;
@property (nonatomic, readonly) NSArray  *gallery;
@property (nonatomic, readonly) CFPlaceModel  *venue;

@end
