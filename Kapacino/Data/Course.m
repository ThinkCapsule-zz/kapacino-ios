//
//  Course.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-04.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "Course.h"

@implementation Course
- (instancetype)init:(FIRDataSnapshot*) snapshot
{
    self = [super init];
    if (self) {
        NSDictionary* values = snapshot.value;
        self.uid = values[@"uid"];
        self.courseCode = values[@"courseCode"];
        self.courseName = values[@"courseName"];
        self.term = values[@"term"];
        self.instructor = values[@"instructor"];
        self.creditType = values[@"creditType"];
        self.creditWeight = values[@"creditWeight"];
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
          @"courseName": self.courseName,
          @"courseCode": self.courseCode,
          @"term": self.term,
          @"instructor": self.instructor,
          @"creditType": self.creditType,
          @"creditWeight": self.creditWeight,
      };
}

-(BOOL) isComplete
{
    return self.courseName && self.courseCode && self.term && self.instructor && self.creditType && self.creditWeight;
}

@end
