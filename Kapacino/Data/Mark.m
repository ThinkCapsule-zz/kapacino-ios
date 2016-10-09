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
            self.uid = values[@"uid"];
            self.name = values[@"name"];
            self.mark = values[@"mark"];
            self.weight = values[@"weight"];
            self.type = values[@"type"];
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
        return @{
                 @"name": self.name,
                 @"mark": self.mark,
                 @"weight": self.weight,
                 @"type": self.type
                 };
    }

    -(BOOL) isComplete
    {
        return self.name && self.mark && self.weight && self.type;
    }

@end
