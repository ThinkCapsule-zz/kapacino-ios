//
//  CFBlogModel.h
//  Kapacino
//
//  Created by Alan Hsu on 2015-11-26.
//  Copyright © 2015 Alan Hsu. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CFBlogModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, readonly) NSString *seriesName;
@property (nonatomic, readonly) NSString *headline;
@property (nonatomic, readonly) NSString *byline;
@property (nonatomic, readonly) NSString *publishDate;
@property (nonatomic, readonly) NSArray  *thumbnails;
@property (nonatomic, readonly) NSArray  *tags;

@end
