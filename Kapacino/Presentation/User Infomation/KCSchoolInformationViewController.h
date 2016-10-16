//
//  KCSchoolInformationViewController.h
//  Kapacino
//
//  Created by Igor Czarev on 4/1/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCViewController.h"
#import "User.h"

@interface KCSchoolInformationViewController : KCViewController

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) User *user;

@end
