//
//  KCEventDetailMoreDetailTableViewController.h
//  Kapacino
//
//  Created by Ivan Cheung on 2016-09-12.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFEventModel.h"

@interface KCEventDetailMoreDetailTableViewController : UITableViewController
    @property (strong, nonatomic) CFEventModel* model;
@end
