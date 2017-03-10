//
//  KCSchoolInformationViewController.h
//  Kapacino
//
//  Created by Igor Czarev on 4/1/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCViewController.h"
#import "KCSchoolInformationTableViewController.h"
#import "User.h"

@protocol KCSchoolInformationViewControllerDelegate <NSObject>
-(void) onInfoFinished;
@end

@interface KCSchoolInformationViewController : KCViewController <KCSchoolInformationTableViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) User *user;
@property (weak, nonatomic) id<KCSchoolInformationViewControllerDelegate> delegate;

@end
