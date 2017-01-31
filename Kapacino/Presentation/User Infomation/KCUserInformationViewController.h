//
//  KCUserInformationViewController.h
//  Kapacino
//
//  Created by Igor Czarev on 4/1/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCViewController.h"
#import "KCSchoolInformationViewController.h"
#import "User.h"

@protocol KCUserInformationViewControllerDelegate <NSObject>
-(void) onInfoFinished;
@end

@interface KCUserInformationViewController : KCViewController <KCSchoolInformationViewControllerDelegate>

@property (strong, nonatomic) User *user;
@property (weak, nonatomic) id<KCUserInformationViewControllerDelegate> delegate;

@end
