//
//  CFArticleModel.h
//  Kapacino
//
//  Created by Alan Hsu on 2015-11-26.
//  Copyright © 2015 Alan Hsu. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CFArticleModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, readonly) NSString *headline;
@property (nonatomic, readonly) NSString *subtitle;
@property (nonatomic, readonly) NSString *author;
@property (nonatomic, readonly) NSString *body;
@property (nonatomic, readonly) NSString *publishDate;
@property (nonatomic, readonly) NSArray  *thumbnails;
@property (nonatomic, readonly) NSArray  *tags;

@end
