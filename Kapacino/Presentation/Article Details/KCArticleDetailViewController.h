//
//  KCArticleDetailViewController.h
//  Kapacino
//
//  Created by Alan Hsu on 2016-02-17.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFArticleModel.h"

@interface KCArticleDetailViewController : UIViewController

- (void)updateWithModel:(CFArticleModel *)articleModel;

@end
