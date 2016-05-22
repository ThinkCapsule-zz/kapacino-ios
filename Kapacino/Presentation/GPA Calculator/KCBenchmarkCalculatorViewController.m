//
//  KCBenchmarkCalculatorViewController.m
//  Kapacino
//
//  Created by Igor Czarev on 3/23/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCBenchmarkCalculatorViewController.h"
#import "KCBenchmarkCaculatorTableViewController.h"

@interface KCBenchmarkCalculatorViewController () <KCBenchmarkCaculatorTableViewControllerDelegate>

@property (weak, nonatomic)  KCBenchmarkCaculatorTableViewController *benchmarkTableViewController;
@property (weak, nonatomic) IBOutlet UILabel *diagramTopLabel;
@property (weak, nonatomic) IBOutlet UILabel *diagramBottomLabel;

@end

@implementation KCBenchmarkCalculatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    [self updateBenchmarkDiagram];
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[KCBenchmarkCaculatorTableViewController class]]) {
        self.benchmarkTableViewController = segue.destinationViewController;
        self.benchmarkTableViewController.model = self.model;
        self.benchmarkTableViewController.delegate = self;
    }
}

- (void)updateBenchmarkDiagram {
    
    if (self.model.benchmark) {
        self.benchmarkTotalLabel.hidden = NO;
        self.diagramTopLabel.hidden = NO;
        self.diagramBottomLabel.hidden = NO;
        self.benchmarkTotalLabel.text = [NSString stringWithFormat:@"%.f%%",self.model.benchmark.floatValue];
    } else {
        self.benchmarkTotalLabel.hidden = YES;
        self.diagramTopLabel.hidden = YES;
        self.diagramBottomLabel.hidden = YES;
    }
}

-(void)benchmarkCaculatorTableViewController:(KCBenchmarkCaculatorTableViewController *)controller didChangeModel:(CFClassModel *)model {
    self.model = model;
    [self updateBenchmarkDiagram];
}

@end
