//
//  CFPlaceModel.h
//  Kapacino
//
//  Created by Ivan Cheung on 2016-09-15.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CFPlaceModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *descriptionText;
@property (nonatomic, readonly) NSString *website;
@property (nonatomic, readonly) NSString *address;
@property (nonatomic, readonly) NSString *phoneNumber;
@property (nonatomic, readonly) NSString *menu;
@property (nonatomic, readonly) NSDictionary  *hours;
@property (nonatomic, readonly) NSString  *backgroundImageId;
@property (nonatomic, readonly) NSString  *type;
@property (nonatomic, readonly) NSArray<NSString *>  *gallery;
@property (nonatomic, readonly) NSDate *updatedAt;
@property (nonatomic, readonly) NSArray  *tags;

@property (nonatomic, readonly) BOOL isOnCampus;
@property (nonatomic, readonly) BOOL isStudentCardAccepted;
@property (nonatomic, readonly) NSArray* creditCardsAccepted;
@end
