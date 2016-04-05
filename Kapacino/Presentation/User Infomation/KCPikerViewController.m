//
//  KCPikerViewController.m
//  Kapacino
//
//  Created by Igor Czarev on 4/1/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCPikerViewController.h"

@interface KCPikerViewController () <KCPickerTableViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;

@end

@implementation KCPikerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.categoryNameLabel.text = self.categoryName;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[KCPickerTableViewController class]]) {
        self.pickerTableViewController = segue.destinationViewController;
        self.pickerTableViewController.items = self.categoryItems;
        self.pickerTableViewController.delegate = self;
    }
}

- (void)pickerTableViewController:(KCPickerTableViewController *)controller didSelectValue:(NSString *)value {
    NSString *key = [self.categoryName substringToIndex:self.categoryName.length - 1];
    [self.userInfo setValue:value forKey:key];
    if ([self.delegate respondsToSelector:@selector(pickerViewController:didChangeUserInfo:)]) {
        [self.delegate pickerViewController:self didChangeUserInfo:self.userInfo];
    }
}

@end
