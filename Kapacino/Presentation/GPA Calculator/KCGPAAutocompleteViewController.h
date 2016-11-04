//
//  KCGPAAutocompleteViewController.h
//  Kapacino
//
//  Created by Ivan Cheung on 2016-11-03.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLPAutoCompleteTextField.h"

@protocol KCCPAAutocompleteDelegate <NSObject>
    @optional
    -(void) didAutocompleteSelectString:(NSString*) string withObject:(id<MLPAutoCompletionObject>) object;

@end

@interface KCGPAAutocompleteViewController : UIViewController <MLPAutoCompleteTextFieldDelegate>
    @property (strong, nonatomic) id <MLPAutoCompleteTextFieldDataSource> autoCompleteDataSource;
    @property (strong, nonatomic) NSString* defaultText;
    @property (weak) id <KCCPAAutocompleteDelegate> delegate;
@end
