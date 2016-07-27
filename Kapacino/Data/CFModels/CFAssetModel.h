//
//  CFAssetModel.h
//  Kapacino
//
//  Created by Alan Hsu on 2016-02-22.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CFAssetModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, readonly) NSDictionary *sys;

@end
