//
//  KCSearchViewController.m
//  Kapacino
//
//  Created by Igor Czarev on 4/5/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCSearchViewController.h"
#import "KCSearchResultTableViewCell.h"
#import "UIColor+KCAdditions.h"

@interface KCSearchViewController ()<UITextFieldDelegate, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *allCities;
@property (weak, nonatomic) IBOutlet UITableView *searchResultTableView;
@property (strong, nonatomic) NSArray *searchResult;
@property (strong, nonatomic) NSString *searchString;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@end

@implementation KCSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadJSON];
    self.searchTextField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    self.categoryNameLabel.text = self.categoryName;
}

- (NSMutableArray *)allCities {
    if (!_allCities) {
        _allCities = [[NSMutableArray alloc] init];
    }
    return _allCities;
}

- (void)loadJSON {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"countriesToCities" ofType:@"json"];
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUnicodeStringEncoding error:nil];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[myJSON dataUsingEncoding:NSUnicodeStringEncoding] options:kNilOptions error:nil];
    self.allCities = [json objectForKey:@"Canada"];

}

- (void)searchItemWithString:(NSString *)string {
    NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", string];
    NSArray *searchResult = [self.allCities filteredArrayUsingPredicate:namePredicate];
    self.searchResult = searchResult;
    self.searchString = string;
    [self.searchResultTableView reloadData];
}

- (void)searchControllerSetValue:(NSString *)value {
    NSString *key = [self.categoryName substringToIndex:self.categoryName.length - 1];
    [self.userInfo setObject:value forKey:key];
    if ([self.delegate respondsToSelector:@selector(searchViewController:didChangeUserInfo:)] ) {
        [self.delegate searchViewController:self didChangeUserInfo:self.userInfo];
    }

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResult.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KCSearchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchResultCell" forIndexPath:indexPath];
    
    NSString *cityName = [self.searchResult objectAtIndex:indexPath.row];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:cityName];
    UIColor *color = [UIColor kc_ApplicationColor];
    NSRange range = [cityName rangeOfString:[cityName substringToIndex:self.searchString.length]];
    [attributedString addAttributes:@{ NSForegroundColorAttributeName:color } range:range];
    
    cell.title.attributedText = attributedString;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     NSString *cityName = [self.searchResult objectAtIndex:indexPath.row];
    self.searchTextField.text = cityName;
    [self searchControllerSetValue:cityName];
}


- (IBAction)searchTextFieldEditingChanged:(UITextField *)sender {
    [self searchItemWithString:sender.text];
}

- (IBAction)searchTextFieldEditingEnd:(UITextField *)sender {
    
}

#pragma mark - Text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self searchControllerSetValue:self.searchResult.firstObject];
    [textField endEditing:YES];
    return YES;
}

@end
