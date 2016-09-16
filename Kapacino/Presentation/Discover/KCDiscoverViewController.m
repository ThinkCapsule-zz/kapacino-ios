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
#import "KCEventDetailViewController.h"
#import "CFClient.h"
#import "CFPlaceModel.h"

@interface KCDiscoverViewController()
@end

static NSString* kRestaurantSegue = @"showRestaurantDetail";
static NSString* kEventSegue = @"showEventDetail";

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
        
        NSDictionary* venueDictionary = model.venue;
        if (venueDictionary != nil)
        {
            //Get the venue
            [CFClient fetchWithContentTypeId:CFContentType_Place andEntryId:venueDictionary[@"sys"][@"id"] completion:^(NSDictionary *result, NSError *error) {
                CFPlaceModel* place = [MTLJSONAdapter modelOfClass:[CFPlaceModel class] fromJSONDictionary:result[@"fields"] error:nil];
                
                [cell updateWithHeadline:model.name andByline:place.name andDateLine:nil andTags:model.types andImageId:model.backgroundImageId];
            }];
        }
        else
        {
            [cell updateWithHeadline:model.name andByline:nil andDateLine:nil andTags:model.types andImageId:model.backgroundImageId];
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.contentType)
    {
        case CFContentType_Restaurant:
            [self performSegueWithIdentifier:kRestaurantSegue sender:self.contentModels[indexPath.row]];
            break;
        case CFContentType_Event:
            [self performSegueWithIdentifier:kEventSegue sender:self.contentModels[indexPath.row]];
            break;
        default:
            break;
    }
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kRestaurantSegue])
    {
        KCRestaurantDetailViewController* detailVC = segue.destinationViewController;
        
        detailVC.model = (CFRestaurantModel*) sender;
    }
    else if ([segue.identifier isEqualToString:kEventSegue])
    {
        KCEventDetailViewController* detailVC = segue.destinationViewController;
        
        detailVC.model = (CFEventModel*) sender;
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
