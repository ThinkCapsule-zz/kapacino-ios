//
//  ViewController.m
//  Kapacino
//
//  Created by Alan Hsu on 2015-11-26.
//  Copyright © 2015 Alan Hsu. All rights reserved.
//

#import "ViewController.h"
#import "CFClient.h"
#import "CFDataSourceConstants.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // Sample fetch
    __weak typeof(self)weakSelf = self;
    [CFClient fetchWithContentTypeId:CFArticleTypeIdentifier completion:^(NSDictionary *response, NSError *error) {
        [weakSelf parseResponseObjects:response];
    }];
}

- (void)parseResponseObjects:(NSDictionary *)response {


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
