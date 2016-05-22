//
//  UINavigationController+Advanced.m
//  Kapacino
//
//  Created by How Else on 3/21/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "UINavigationController+Advanced.h"

@implementation UINavigationController (Advanced)

- (void)pushViewController:(UIViewController *)viewController fromViewController:(UIViewController *)fromViewController animated:(BOOL)animated
{
    NSMutableArray *controllers = [self.viewControllers mutableCopy];
    NSUInteger numberOfControllers = controllers.count;
    NSUInteger currentIndex = [controllers indexOfObject:fromViewController];
    
    if (currentIndex != NSNotFound && currentIndex < numberOfControllers) {
        NSUInteger nextIndex = currentIndex + 1;
        NSRange range = NSMakeRange(nextIndex, numberOfControllers - nextIndex);
        [controllers removeObjectsInRange:range];
    }
    [controllers addObject:viewController];
    
    [self setViewControllers:controllers animated:animated];
}

@end
