//
//  JsonDatasource.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-11-06.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "JsonDatasource.h"
#import <Mantle/Mantle.h>

@interface JsonDatasource()
    @property (strong, readwrite) NSArray* data;
    @property (strong, nonatomic) NSMutableDictionary* idToDataMap;
@end

@implementation JsonDatasource
    -(id) init
    {
        if (!self.isInitialized) {
            self = [super init];
            
            if (self) {
                // Initialize self.
            }
        }
        
        NSString* filename = [self getDataFilename];
        
        NSError* error;
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        self.data = [MTLJSONAdapter modelsOfClass:[self getDataClass] fromJSONArray:jsonArray error:&error];
        
        //Store data in dictionary
        self.idToDataMap = [[NSMutableDictionary alloc] init];
        for (id data in self.data)
        {
            NSString* key = [data valueForKey:@"uid"];
            
            if (key)
            {
                self.idToDataMap[key] = data;
            }
        }
        
        return self;
    }

    #pragma Override functions
    -(Class) getDataClass
    {
        return nil;
    }

    -(NSString*) getDataFilename
    {
        return nil;
    }

    -(id) getById:(NSString*) uid
    {
        return self.idToDataMap[uid];
    }

@end
