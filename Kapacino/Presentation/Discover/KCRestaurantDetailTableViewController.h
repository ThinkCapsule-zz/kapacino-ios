//
//  KCRestaurantDetailTableViewController.h
//  Kapacino
//
//  Created by Ivan Cheung on 2016-09-05.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFRestaurantModel.h"

@interface KCRestaurantDetailTableViewController : UITableViewController
    @property (strong, nonatomic) CFRestaurantModel* model;
@end
