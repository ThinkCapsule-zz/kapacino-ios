//
//  SchoolRegistrationViewController.h
//  Kapacino
//
//  Created by Alan Hsu on 2016-02-27.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SchoolRegistrationViewControllerDelegate <NSObject>

- (void)didCompleteSchoolRegistration:(BOOL)completed;

@end

@interface SchoolRegistrationViewController : UIViewController

@property (nonatomic, weak) id <SchoolRegistrationViewControllerDelegate> delegate;

@end


