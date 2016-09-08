//
//  KCDiscoverViewController.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-08-12.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "KCDiscoverViewController.h"
#import "CFRestaurantModel.h"
#import "CFListingModel.h"
#import "CFEventModel.h"
#import "KCRestaurantDetailViewController.h"

@interface KCDiscoverViewController()
@end

static NSString* kRestaurantSegue = @"showRestaurantDetail";

@implementation KCDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updateCell:(KCFeedCell*)cell forContentModel:(NSObject *)contentModel
{
    if (self.contentType == CFContentType_Restaurant)
    {
        CFRestaurantModel* model = (CFRestaurantModel*) contentModel;
        [cell updateWithHeadline:model.name andByline:model.descriptionText andDateLine:nil andTags:model.tags andImageId:model.backgroundImageId];
    }
    else if (self.contentType == CFContentType_Listing)
    {
        CFListingModel* model = (CFListingModel*) contentModel;
        NSDictionary* dictionary = [model.thumbnails firstObject];
        NSString* assetId = dictionary[@"sys"][@"id"];
        [cell updateWithHeadline:model.listname andByline:model.location andDateLine:nil andTags:nil andImageId:assetId];
    }
    else if (self.contentType == CFContentType_Event)
    {
        CFEventModel* model = (CFEventModel*) contentModel;
        NSDictionary* dictionary = [model.thumbnails firstObject];
        NSString* assetId = dictionary[@"sys"][@"id"];
        [cell updateWithHeadline:model.listname andByline:model.location andDateLine:nil andTags:nil andImageId:assetId];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:kRestaurantSegue sender:self.contentModels[indexPath.row]];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kRestaurantSegue])
    {
        KCRestaurantDetailViewController* detailVC = segue.destinationViewController;
        
        detailVC.model = (CFRestaurantModel*) sender;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
