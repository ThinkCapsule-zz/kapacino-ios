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
@property (weak, nonatomic) IBOutlet UIView *primaryTagBackground;

@property (nonatomic, strong) CFArticleModel *articleModel;

@end

@implementation KCFeedCell

- (void)awakeFromNib {
    
    self.backgroundImageView.image = [UIImage imageNamed:@"cellBackground_placeholder"];
    self.headline.font             = [UIFont kc_MediumFontWithSize:16.0f];
    self.byline.font               = [UIFont kc_RegularFontWithSize:12.0f];
    self.dateLine.font             = [UIFont kc_RegularFontWithSize:12.0f];
    self.primaryTag.font           = [UIFont kc_RegularFontWithSize:12.0f];
    
}

- (void)prepareForReuse {
    
    self.articleModel              = nil;
    self.headline.text             = @"";
    self.byline.text               = @"";
    self.dateLine.text             = @"";
    self.primaryTag.text           = @"";
    self.backgroundImageView.image = nil;
}

#pragma mark - Update
- (void)updateWithArticleModel:(CFArticleModel *)articleModel {
    
    self.articleModel = articleModel;
    
    self.headline.text   = self.articleModel.headline;
    self.byline.text     = self.articleModel.byline;
    self.dateLine.text   = self.articleModel.publishDate;
    
    NSString *tag = (NSString*)[self.articleModel.tags firstObject];
    self.primaryTag.text = tag;
    self.primaryTagBackground.hidden = tag ? NO : YES;
    
    [self updateCellImage];
    
}

- (void)updateCellImage {
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self.articleModel.thumnailURLs firstObject]]];
    UIImage *image = [UIImage imageWithData:imageData];
    self.backgroundImageView.image = image ? image : [UIImage imageNamed:@"cellBackground_placeholder"];
        
        
    
}

@end
