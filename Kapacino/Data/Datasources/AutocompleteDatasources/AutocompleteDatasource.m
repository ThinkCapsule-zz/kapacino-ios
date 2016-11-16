//
//  AutocompleteDatasource.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-27.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "AutocompleteDatasource.h"

@interface AutocompleteDatasource()
    
@end

@implementation AutocompleteDatasource
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
            NSArray* filteredArray = self.predicate ? [self.data filteredArrayUsingPredicate:self.predicate] : self.data;
            
            handler(filteredArray);
        });
    }
//    -(AutocompleteDatasource*) sharedInstance
//    {
//        return nil;
//    }
@end
