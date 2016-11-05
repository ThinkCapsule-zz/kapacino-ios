//
//  KCGPACourseTableViewController.h
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-04.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"
#import "MLPAutoCompleteTextField.h"
#import "KCGPAAutocompleteViewController.h"
#import "KCGPAPickerViewController.h"

@interface KCGPACourseDetailTableViewController : UITableViewController <KCGPAAutocompleteDelegate, KCGPAPickerDelegate>
    @property (strong, nonatomic) Course* course;
@end
