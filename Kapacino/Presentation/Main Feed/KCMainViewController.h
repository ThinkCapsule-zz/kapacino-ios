//
//  KCMainViewController.h
//  Kapacino
//
//  Created by Alan Hsu on 2016-01-24.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFContentType.h"
#import "KCFeedCell.h"

@interface KCMainViewController : UICollectionViewController
    @property (nonatomic) CFContentType contentType;
    @property (nonatomic, strong) NSArray *contentModels;
    -(void) updateCell:(KCFeedCell*) cell forContentModel:(NSObject*) contentModel atRow:(NSInteger) row;
@end
