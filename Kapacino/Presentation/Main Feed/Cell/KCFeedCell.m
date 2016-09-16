//
//  KCFeedCell.m
//  Kapacino
//
//  Created by Alan Hsu on 2016-01-24.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCFeedCell.h"
#import "UIFont+KCAdditions.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIColor+KCAdditions.h"
#import "CFClient.h"

@interface KCFeedCell()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UILabel *byline;
@property (weak, nonatomic) IBOutlet UILabel *dateLine;
@property (weak, nonatomic) IBOutlet UILabel *primaryTag;
@property (weak, nonatomic) IBOutlet UIView *primaryTagBackground;

@end

@implementation KCFeedCell

- (void)awakeFromNib {
    
    self.backgroundImageView.image            = [UIImage imageNamed:@"cellBackground_placeholder"];
    self.headline.font                        = [UIFont kc_MediumFontWithSize:16.0f];
    self.byline.font                          = [UIFont kc_RegularFontWithSize:12.0f];
    self.dateLine.font                        = [UIFont kc_RegularFontWithSize:12.0f];
    self.primaryTag.font                      = [UIFont kc_RegularFontWithSize:12.0f];
    self.primaryTagBackground.backgroundColor = [UIColor kc_PrimaryTagColour];
    
}

- (void)prepareForReuse {
    self.headline.text             = @"";
    self.byline.text               = @"";
    self.dateLine.text             = @"";
    self.primaryTag.text           = @"";
    self.backgroundImageView.image = nil;
}

#pragma mark - Update
- (void)updateWithHeadline:(NSString *)headline andByline:(NSString *)byline andDateLine:(NSString *)dateLine andTags:(NSArray*) tags andImageId:(NSString*) assetId andRow:(NSInteger) row {
    
    if (assetId != nil)
    {
        [CFClient fetchImageWithId:assetId completion:^(NSURL *imageURL, NSError *error) {
            if ((error == nil)&&(self.tag == row))
            {
                [self updateWithHeadline:headline andByline:byline andDateLine:dateLine andTags:tags andImageUrl:imageURL];
            }
        }];
    }
    else
    {
        [self updateWithHeadline:headline andByline:byline andDateLine:dateLine andTags:tags andImageUrl:nil];
    }
}

- (void) updateByline:(NSString*) byline
{
    self.byline.text = byline;
}

- (void)updateWithHeadline:(NSString *)headline andByline:(NSString *)byline andDateLine:(NSString *)dateLine andTags:(NSArray*) tags andImageUrl:(NSURL*) imageUrl {
    
    self.headline.text   = headline;
    self.byline.text     = byline;
    self.dateLine.text   = dateLine;
    
    NSString *tag = [(NSString*)[tags firstObject] uppercaseString];
    self.primaryTag.text = tag;
    self.primaryTagBackground.hidden = tag ? NO : YES;
    
    [self updateCellImage:imageUrl];
}

- (void)updateCellImage:(NSURL*) imageUrl {
    [self.backgroundImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"image_placeholder"]];
}

@end
