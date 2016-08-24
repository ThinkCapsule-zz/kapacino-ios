//
//  KCMainViewController.h
//  Kapacino
//
//  Created by Alan Hsu on 2016-01-24.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFContentType.h"

@interface KCMainViewController : UICollectionViewController
    @property (nonatomic, readonly) CFContentType contentType;
@end
