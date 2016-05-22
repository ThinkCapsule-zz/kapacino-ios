//
//  CFVideoModel.h
//  Kapacino
//
//  Created by Alan Hsu on 2015-11-26.
//  Copyright © 2015 Alan Hsu. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CFVideoModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSArray  *media;
@property (nonatomic, readonly) NSString *byline;
@property (nonatomic, readonly) NSArray  *publishDate;
@property (nonatomic, readonly) NSArray  *thumbnails;

@end
