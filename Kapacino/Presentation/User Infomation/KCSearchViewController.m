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

@property (weak, nonatomic) IBOutlet UITableView *searchResultTableView;
@property (strong, nonatomic) NSArray *searchResult;
@property (strong, nonatomic) NSString *searchString;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@end

@implementation KCSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self loadJSON];
    self.searchTextField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    self.categoryNameLabel.text = self.categoryName;
    [self showDefaultItems];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

-(void) setSearchResult:(NSArray *)searchResult
{
    NSArray* sortedResults;
    if (self.nameKeyPath)
    {
        sortedResults = [searchResult sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 valueForKeyPath:self.nameKeyPath] > [obj1 valueForKeyPath:self.nameKeyPath];
        }];
    }
    else
    {
        sortedResults = [searchResult sortedArrayUsingSelector:@selector(compare:)];
    }
    
    _searchResult = sortedResults;
}

- (void)searchItemWithString:(NSString *)string {
    if (self.items)
    {
        if (string.length)
        {
            NSPredicate *namePredicate;
            if (self.nameKeyPath)
            {
                namePredicate = [NSPredicate predicateWithFormat:@"%K beginswith[c] %@", self.nameKeyPath, string];
            }
            else
            {
                namePredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", string];
            }
            
            NSArray *searchResult = [self.items filteredArrayUsingPredicate:namePredicate];
            self.searchResult = searchResult;
            self.searchString = string;
            [self.searchResultTableView reloadData];
        }
        else
        {
            [self showDefaultItems];
        }
    }
}

- (void)searchControllerSetValue:(NSString *)value {
    if ([self.delegate respondsToSelector:@selector(searchViewController:didChangeUserInfo:)] ) {
        [self.delegate searchViewController:self didChangeUserInfo:value];
    }
    
    if (value)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void) showDefaultItems
{
    self.searchResult = self.items;
    [self.searchResultTableView reloadData];
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
    
    NSObject* item = [self.searchResult objectAtIndex:indexPath.row];
    NSString *itemName = self.nameKeyPath ? [item valueForKeyPath:self.nameKeyPath] : item;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:itemName];
    UIColor *color = [UIColor kc_ApplicationColor];
    NSRange range = [itemName rangeOfString:[itemName substringToIndex:self.searchString.length]];
    [attributedString addAttributes:@{ NSForegroundColorAttributeName:color } range:range];
    
    cell.title.attributedText = attributedString;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject *item = [self.searchResult objectAtIndex:indexPath.row];
    NSString* itemName = self.nameKeyPath ? [item valueForKeyPath:self.nameKeyPath] : item;
    NSString* itemId = self.idKeyPath ? [item valueForKeyPath:self.idKeyPath] : item;
    self.searchTextField.text = itemName;
    [self searchControllerSetValue:itemId];
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
