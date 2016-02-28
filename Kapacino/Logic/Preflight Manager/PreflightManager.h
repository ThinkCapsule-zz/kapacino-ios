//
//  PreflightManager.h
//  Kapacino
//
//  Created by Alan Hsu on 2016-02-27.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PreflightManager : NSObject

/**
 Singleton instance
 */
+ (instancetype)sharedInstance;

/**
 Preflight manager requires a reference to the navigation controller
 */
- (void)updateWithNavigationController:(UIViewController *)navigationController;

/**
 Perform work that needs to be done to onboard the user for the first time
 */
- (void)runPreflight;

- (void)didCompleteRegistrationFlow:(BOOL)completed;

@end
