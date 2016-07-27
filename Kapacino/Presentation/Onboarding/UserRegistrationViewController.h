//
//  RegistrationViewController.h
//  Kapacino
//
//  Created by Alan Hsu on 2016-02-27.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserRegistrationViewControllerDelegate <NSObject>

- (void)didCompleteUserRegistration:(BOOL)completed;

@end

@interface UserRegistrationViewController : UIViewController

@property (nonatomic, weak) id <UserRegistrationViewControllerDelegate> delegate;

@end
