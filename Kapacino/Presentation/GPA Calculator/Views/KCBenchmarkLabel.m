//
//  KCBenchmarkLabel.m
//  Kapacino
//
//  Created by Igor Czarev on 3/23/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCBenchmarkLabel.h"

@implementation KCBenchmarkLabel

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.clipsToBounds = YES;
    self.adjustsFontSizeToFitWidth = YES;
    self.minimumScaleFactor = 0.5;
}

@end
