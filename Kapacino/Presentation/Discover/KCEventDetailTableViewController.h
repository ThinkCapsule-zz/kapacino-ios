//
//  KCEventDetailTableViewController.h
//  Kapacino
//
//  Created by Ivan Cheung on 2016-09-05.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFEventModel.h"
#import "CFPlaceModel.h"

@interface KCEventDetailTableViewController : UITableViewController
    @property (strong, nonatomic) CFEventModel* model;
    @property (strong, nonatomic) CFPlaceModel* place;
@end
