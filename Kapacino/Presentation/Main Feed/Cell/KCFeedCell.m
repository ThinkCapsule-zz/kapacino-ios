//
//  KCFeedCell.m
//  Kapacino
//
//  Created by Alan Hsu on 2016-01-24.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCFeedCell.h"
#import "UIFont+KCAdditions.h"

@interface KCFeedCell()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UILabel *byline;
@property (weak, nonatomic) IBOutlet UILabel *dateLine;
@property (weak, nonatomic) IBOutlet UILabel *primaryTag;
@end

@implementation KCFeedCell

- (void)awakeFromNib {
    
    self.backgroundImageView.image = [UIImage imageNamed:@"cellBackground"];
    self.headline.font             = [UIFont kc_MediumFontWithSize:14.0f];
    self.byline.font               = [UIFont kc_RegularFontWithSize:12.0f];
    self.dateLine.font             = [UIFont kc_LightFontWithSize:10.0f];
    self.primaryTag.font           = [UIFont kc_LightFontWithSize:10.0f];
    
}

- (void)prepareForReuse {
    
    self.headline.text   = @"";
    self.byline.text     = @"";
    self.dateLine.text   = @"";
    self.primaryTag.text = @"";
}

#pragma mark - Update
- (void)updateWithArticleModel:(CFArticleModel *)articleModel {
    
    self.headline.text = articleModel.headline;
    self.byline.text   = articleModel.byline;
    self.dateLine.text = articleModel.publishDate;
    self.primaryTag.text = [articleModel.tags firstObject];
    
}

@end
