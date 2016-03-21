//
//  CFClassItem.h
//  Kapacino
//
//  Created by Igor Czarev on 3/22/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFClassItem : NSObject

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *mark;
@property (nonatomic, copy) NSNumber *weight;

@end
