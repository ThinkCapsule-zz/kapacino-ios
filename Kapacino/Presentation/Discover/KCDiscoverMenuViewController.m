//
//  KCDiscoverMenuViewController.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-08-22.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "KCDiscoverMenuViewController.h"
#import "KCDiscoverViewController.h"
#import "KCDiscoverMenuCell.h"
#import "CFContentType.h"

@interface KCDiscoverMenuViewController ()
    @property (strong, nonatomic) NSArray* discoverCategories;
    @property (strong, nonatomic) NSArray* discoverSubtitles;
    @property (strong, nonatomic) NSArray* discoverCategoryContentTypes;
    @property (strong, nonatomic) NSArray* discoverImageNames;
@end

static NSString* kDiscoverSegue = @"showDiscoverScreen";

@implementation KCDiscoverMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.discoverCategories = @[@"Restaurants", @"Events", @"Listings"];
    self.discoverSubtitles = @[@"Find great eats on or off campus", @"Find out what's going around campus", @"Find great spots to live close to campus"];
    self.discoverCategoryContentTypes = @[@(CFContentType_Restaurant), @(CFContentType_Event), @(CFContentType_Listing)];
    self.discoverImageNames = @[@"discover_restaurants",@"discover_events",@"discover_listings"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.discoverCategories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KCDiscoverMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    // Initialization code
    cell.imageViewIcon.image = [UIImage imageNamed:self.discoverImageNames[indexPath.row]];
    cell.labelTitle.text = self.discoverCategories[indexPath.row];
    cell.labelSubtitle.text = self.discoverSubtitles[indexPath.row];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber* contentTypeWrapped = self.discoverCategoryContentTypes[indexPath.row];
    [self performSegueWithIdentifier:kDiscoverSegue sender:contentTypeWrapped];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CFContentType contentType = [((NSNumber*) sender) intValue];
    
    if ([segue.identifier isEqualToString:kDiscoverSegue])
    {
        ((KCDiscoverViewController*) segue.destinationViewController).contentType = contentType;
    }
}

@end
