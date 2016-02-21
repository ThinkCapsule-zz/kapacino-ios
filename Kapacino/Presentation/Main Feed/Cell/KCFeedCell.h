//
//  KCFeedCell.h
//  Kapacino
//
//  Created by Alan Hsu on 2016-01-24.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFArticleModel.h"

@interface KCFeedCell : UICollectionViewCell

- (void)updateWithArticleModel:(CFArticleModel *)articleMode;

@end
