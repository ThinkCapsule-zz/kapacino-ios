//
//  KCRestaurantViewController.h
//  Kapacino
//
//  Created by Ivan Cheung on 2016-09-03.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFRestaurantModel.h"

@interface KCRestaurantDetailViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
    @property (strong, nonatomic) CFRestaurantModel* model;
@end
