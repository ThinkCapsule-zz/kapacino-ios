//
//  KCSchoolInformationTableViewController.h
//  Kapacino
//
//  Created by Igor Czarev on 4/5/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCUserInfoTableViewController.h"

@protocol KCSchoolInformationTableViewControllerDelegate <NSObject>
    -(void) onUniversityEmailChanged;
@end

@interface KCSchoolInformationTableViewController : KCUserInfoTableViewController
    @property (strong, nonatomic) id<KCSchoolInformationTableViewControllerDelegate> delegate;
@end
