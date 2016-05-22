//
//  KCLoadingPage.m
//  Kapacino
//
//  Created by Igor Czarev on 4/7/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCLoadingPage.h"

@implementation KCLoadingPage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.closeBarButton;
}

- (IBAction)closeBarButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
