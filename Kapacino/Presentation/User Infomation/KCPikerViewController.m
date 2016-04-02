//
//  KCPikerViewController.m
//  Kapacino
//
//  Created by Igor Czarev on 4/1/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCPikerViewController.h"

@interface KCPikerViewController ()

@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;

@end

@implementation KCPikerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.categoryNameLabel.text = self.categoryName;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[KCPickerTableViewController class]]) {
        self.pickerTableView = segue.destinationViewController;
        self.pickerTableView.items = self.categoryItems;
        self.pickerTableView.categoryName = self.categoryName;
        self.pickerTableView.delegate = self.delegate;
    }
}

@end
