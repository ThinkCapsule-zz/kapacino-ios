//
//  KCAvatarImageView.m
//  Kapacino
//
//  Created by Igor Czarev on 3/25/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCAvatarImageView.h"

@interface KCAvatarImageView ()

@property (strong, nonatomic) CALayer *shadowLayer;

@end


@implementation KCAvatarImageView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CGFloat cornerRadius = self.frame.size.height / 2;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                          cornerRadius:cornerRadius];
    
    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds = YES;
    
    self.shadowLayer.frame = self.frame;
    self.shadowLayer.shadowPath = shadowPath.CGPath;
    
    [self.superview.layer insertSublayer:self.shadowLayer below:self.layer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.shadowLayer.frame = self.frame;
}

- (CALayer *)shadowLayer {
    if (!_shadowLayer) {
        _shadowLayer = [CALayer layer];
        _shadowLayer.shadowColor = [UIColor blackColor].CGColor;
        _shadowLayer.shadowRadius = 2;
        _shadowLayer.shadowOpacity = 0.5;
        _shadowLayer.shadowOffset = CGSizeMake(0.0, 3.0);
    }
    return _shadowLayer;
}

@end
