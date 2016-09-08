//
//  KCImageCellCollectionViewCell.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-09-06.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "KCImageCell.h"
#import "CFClient.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface KCImageCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation KCImageCell

    -(void) setImageId:(NSString *)imageId
    {
        _imageId = imageId;
        
        [CFClient fetchAssetWithId:imageId completion:^(NSURL *imageURL, NSError *error) {
            if (error == nil)
            {
                [self.imageView sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"image_placeholder"]];
            }
        }];
    }
@end
