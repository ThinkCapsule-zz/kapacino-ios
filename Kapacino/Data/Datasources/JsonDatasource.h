//
//  JsonDatasource.h
//  Kapacino
//
//  Created by Ivan Cheung on 2016-11-06.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import <DOSingleton/DOSingleton.h>

@interface JsonDatasource : DOSingleton
    @property (strong, readonly) NSArray* data;
    -(NSString*) getDataFilename;
    -(Class) getDataClass;
    -(id) getById:(NSString*) uid;
@end
