//
//  ViewController.m
//  Kapacino
//
//  Created by Alan Hsu on 2015-11-26.
//  Copyright © 2015 Alan Hsu. All rights reserved.
//

#import "KCMainViewController.h"
#import "CFClient.h"
#import "CFDataSourceConstants.h"
#import "CFModelFactory.h"

@interface KCMainViewController ()

@property (nonatomic, strong) NSArray *sample;

@end

@implementation KCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.sample = [[NSArray alloc] init];
    
    // Sample fetch
    [CFClient fetchWithContentTypeId:CFContentType_Article completion:^(NSArray *responseItems, NSError *error) {
        NSArray* test = [CFModelFactory parseResponseObjects:responseItems forType:CFContentType_Article];
    }];
    
    [CFClient fetchWithContentTypeId:CFContentType_Blog completion:^(NSArray *responseItems, NSError *error) {
        NSArray* test = [CFModelFactory parseResponseObjects:responseItems forType:CFContentType_Blog];
    }];
    
    [CFClient fetchWithContentTypeId:CFContentType_Video completion:^(NSArray *responseItems, NSError *error) {
        NSArray* test = [CFModelFactory parseResponseObjects:responseItems forType:CFContentType_Places];
    }];
    
    [CFClient fetchWithContentTypeId:CFContentType_Listing completion:^(NSArray *responseItems, NSError *error) {
        NSArray* test = [CFModelFactory parseResponseObjects:responseItems forType:CFContentType_Places];
    }];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
