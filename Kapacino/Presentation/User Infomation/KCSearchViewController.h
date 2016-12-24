//
//  KCSearchViewController.h
//  Kapacino
//
//  Created by Igor Czarev on 4/5/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@protocol KCSearchViewControllerDelegate;

@interface KCSearchViewController : UIViewController

@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) NSString *idKeyPath;
@property (strong, nonatomic) NSString *nameKeyPath;
@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;
@property (strong, nonatomic) NSString *categoryName;

@property (nonatomic, weak) id<KCSearchViewControllerDelegate> delegate;

@end


@protocol KCSearchViewControllerDelegate <NSObject>

- (void)searchViewController:(KCSearchViewController *)controller didChangeUserInfo:(NSString *)info;

@end
