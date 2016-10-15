//
//  Mark.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-08.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "Mark.h"

@implementation Mark
    - (instancetype)init:(FIRDataSnapshot*) snapshot
    {
        self = [super init];
        if (self) {
            NSDictionary* values = snapshot.value;
            self.key = snapshot.key;
            self.name = values[@"name"];
            self.mark = values[@"mark"];
            self.weight = values[@"weight"];
            self.type = values[@"type"];
            self.courseKey = values[@"courseKey"];
        }
        return self;
    }

    //-(void) init(snapshot: FIRDataSnapshot) {
    //    key = snapshot.key
    //    let snapshotValue = snapshot.value as! [String: AnyObject]
    //    name = snapshotValue["name"] as! String
    //    addedByUser = snapshotValue["addedByUser"] as! String
    //    completed = snapshotValue["completed"] as! Bool
    //    ref = snapshot.ref
    //}

    //func toAnyObject() -> Any {
    //    return [
    //            "name": name,
    //            "addedByUser": addedByUser,
    //            "completed": completed
    //            ]
    //}

    -(NSDictionary*) toDictionary
    {
        if (self.isComplete)
        {
            return @{
                 @"name": self.name,
                 @"mark": self.mark,
                 @"weight": self.weight,
                 @"type": self.type,
                 @"courseKey": self.courseKey
                 };
        }
        else
        {
            return nil;
        }
    }

    -(BOOL) isComplete
    {
        return self.name && self.mark && self.weight && self.type && self.courseKey;
    }

@end
