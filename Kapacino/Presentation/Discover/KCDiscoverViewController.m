//
//  KCDiscoverViewController.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-08-12.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "KCDiscoverViewController.h"

@interface KCDiscoverViewController ()

@end

@implementation KCDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CFContentType) contentType
{
    return CFContentType_Events;
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
