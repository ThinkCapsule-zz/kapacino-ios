//
//  KCRestaurantViewController.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-09-03.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "KCRestaurantDetailViewController.h"
#import "KCRestaurantDetailTableViewController.h"
#import "KCRestaurantDetailMoreDetailTableViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CFClient.h"
#import "KCImageCell.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "FSImageViewer.h"
#import "FSBasicImage.h"
#import "FSBasicImageSource.h"

@interface KCRestaurantDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBackground;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelAddressAndTime;
@property (weak, nonatomic) IBOutlet UIView *viewInfo;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewImages;
@property (weak, nonatomic) IBOutlet UIView *constraintContainerViewHeight;
@property (weak, nonatomic) IBOutlet UICollectionView *constraintCollectionViewHeight;
@property (weak, nonatomic) IBOutlet UITextView *labelDescription;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation KCRestaurantDetailViewController

static NSString* kCellIdentifier = @"cell";
static NSString* kEmbedSegue = @"embedSegue";
static NSString* kMoreDetailSegue = @"showMoreDetail";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.labelName.text = self.model.name;
    
    //Get day of week
    NSDateFormatter* dayFormatter = [[NSDateFormatter alloc] init];
    [dayFormatter setDateFormat: @"EEEE"];
    NSString* dayOfWeek = [dayFormatter stringFromDate:[NSDate date]];
    NSString* endTimeForTheDay = self.model.hours[dayOfWeek][@"end"];
    
    self.labelAddressAndTime.text = [NSString stringWithFormat:@"%@ - Closes at %@", self.model.address, endTimeForTheDay];
    self.labelDescription.text = self.model.descriptionText;
    
    if (self.model.backgroundImageId != nil)
    {
        [CFClient fetchImageWithId:self.model.backgroundImageId completion:^(NSURL *imageURL, NSError *error) {
            [self.imageViewBackground sd_setImageWithURL:imageURL placeholderImage:nil];
        }];
    }
    
    [self updateMap:self.model.address];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updateMap:(NSString*) address
{
    NSString *location = address;
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:location
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     if (placemarks && placemarks.count > 0) {
                         CLPlacemark *topResult = [placemarks objectAtIndex:0];
                         MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
                         
                         CLLocationCoordinate2D center = [(CLCircularRegion *)placemark.region center];
                         MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(center, 500, 500);
                         
                         [self.mapView setRegion:region animated:YES];
                         [self.mapView addAnnotation:placemark];
                     }
                 }
     ];
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.model.thumbnailIds.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KCImageCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    cell.imageId = self.model.thumbnailIds[indexPath.item];
    
    return cell;
}

#pragma mark - CollectionViewLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float width = floor(collectionView.bounds.size.width/3);
    return CGSizeMake(width, width);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* imageId = self.model.thumbnailIds[indexPath.item];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]
                                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = self.view.center;
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    [CFClient fetchImageWithId:imageId completion:^(NSURL *imageURL, NSError *error) {
        [spinner stopAnimating];
        [spinner removeFromSuperview];
        
        if (error == nil)
        {
            FSBasicImage *firstPhoto = [[FSBasicImage alloc] initWithImageURL:imageURL name:@""];
            FSBasicImageSource *photoSource = [[FSBasicImageSource alloc] initWithImages:@[firstPhoto]];
            
            FSImageViewerViewController *imageViewController = [[FSImageViewerViewController alloc] initWithImageSource:photoSource];
            [self.navigationController pushViewController:imageViewController animated:YES];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kEmbedSegue])
    {
        KCRestaurantDetailTableViewController* restaurantDetailVC = segue.destinationViewController;
        restaurantDetailVC.model = self.model;
    }
    else if ([segue.identifier isEqualToString:kMoreDetailSegue])
    {
        KCRestaurantDetailMoreDetailTableViewController* moreDetailVC = segue.destinationViewController;
        moreDetailVC.model = self.model;
    }
}

@end

