//
//  KCGPACourseCell.h
//  Kapacino
//
//  Created by Ivan Cheung on 2016-10-04.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KCGPACourseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelCourseCode;
@property (weak, nonatomic) IBOutlet UILabel *labelInstructorName;
@property (weak, nonatomic) IBOutlet UILabel *labelTerm;
@property (weak, nonatomic) IBOutlet UILabel *labelGPA;
@end
