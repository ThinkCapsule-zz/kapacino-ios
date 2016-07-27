//
//  CFClassModel.h
//  Kapacino
//
//  Created by How Else on 3/18/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CFClassItem.h"

@interface CFClassModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *prof;
@property (nonatomic, copy) NSNumber *mark;
@property (nonatomic, copy) NSNumber *benchmark;
@property (nonatomic, copy) NSNumber *dreamMark;
@property (nonatomic, copy) NSNumber *totalWeight;
@property (nonatomic, copy) NSNumber *totalMark;
@property (nonatomic, copy) NSArray *items;

@end
