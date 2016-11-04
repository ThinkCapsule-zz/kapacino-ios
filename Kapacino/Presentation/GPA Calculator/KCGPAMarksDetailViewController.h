//
//  KCGPAMarksDetailViewController.h
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-04.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mark.h"
#import "KCGPAAutocompleteViewController.h"

@interface KCGPAMarksDetailViewController : UITableViewController <KCCPAAutocompleteDelegate>
    @property (strong, nonatomic) Mark* mark;
    @property (strong, nonatomic) NSString* courseKey;
@end
