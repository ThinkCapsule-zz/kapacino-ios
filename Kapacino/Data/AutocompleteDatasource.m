//
//  AutocompleteDatasource.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-27.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "AutocompleteDatasource.h"
#import <Mantle/Mantle.h>

@interface AutocompleteDatasource()
    @property (strong, nonatomic) NSArray* data;
    @property (strong, nonatomic) NSMutableDictionary* idToDataMap;
@end

@implementation AutocompleteDatasource
    static AutocompleteDatasource* instance;

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

    -(void) autoCompleteTextField:(MLPAutoCompleteTextField *)textField possibleCompletionsForString:(NSString *)string completionHandler:(void (^)(NSArray *))handler
    {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        dispatch_async(queue, ^{
//            NSArray *countries =
//            @[
//              @"Essay",
//              @"Exam",
//              @"Assignment",
//              @"Quiz"];
//            
//            //Sort
//            countries = [countries sortedArrayUsingSelector:@selector(compare:)];
            
            handler(self.data);
        });
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

//    -(AutocompleteDatasource*) sharedInstance
//    {
//        return nil;
//    }
@end
