//
//  CFListingModel.h
//  Kapacino
//
//  Created by Alan Hsu on 2015-11-26.
//  Copyright © 2015 Alan Hsu. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CFListingModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, readonly) NSString *listname;
@property (nonatomic, readonly) NSString *location;
@property (nonatomic, readonly) NSString *telephoneNumber;
@property (nonatomic, readonly) NSArray  *thumbnails;

@end
