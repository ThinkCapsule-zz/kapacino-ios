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

@interface KCMainViewController ()

@property (nonatomic, strong) NSArray *sample;

@end

@implementation KCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.sample = [[NSArray alloc] init];
    
    // Sample fetch
    [CFClient fetchWithContentTypeId:CFContentType_Article completion:^(NSArray *responseItems, NSError *error) {
    
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
