//
//  CFListingModel.h
//  Kapacino
//
//  Created by Alan Hsu on 2015-11-26.
//  Copyright © 2015 Alan Hsu. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CFRestaurantModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *descriptionText;
@property (nonatomic, readonly) NSString *website;
@property (nonatomic, readonly) NSString *address;
@property (nonatomic, readonly) NSString *telephoneNumber;
@property (nonatomic, readonly) NSString *menu;
@property (nonatomic, readonly) NSDictionary  *hours;
@property (nonatomic, readonly) NSString  *backgroundImageId;
@property (nonatomic, readonly) NSString  *type;
@property (nonatomic, readonly) NSArray<NSString *>  *thumbnailIds;
@property (nonatomic, readonly) NSDate *updatedAt;
@property (nonatomic, readonly) NSArray  *tags;

@property (nonatomic, readonly) BOOL isOnCampus;
@property (nonatomic, readonly) BOOL isStudentCardAccepted;
@property (nonatomic, readonly) BOOL isCreditCardAccepted;
@property (nonatomic, readonly) BOOL isDeliveryAccepted;
@end
