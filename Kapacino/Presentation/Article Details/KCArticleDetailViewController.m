//
//  KCArticleDetailViewController.m
//  Kapacino
//
//  Created by Alan Hsu on 2016-02-17.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCArticleDetailViewController.h"
#import <KeepLayout/KeepLayout.h>
#import "UIFont+KCAdditions.h"
#import "CFClient.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIColor+KCAdditions.h"
#import <WebKit/WebKit.h>
#import <MMMarkdown/MMMarkdown.h>


@interface KCArticleDetailViewController () <WKNavigationDelegate>

@property (nonatomic, weak) IBOutlet UIButton     *closeButton;

/* Header */
@property (nonatomic, weak) IBOutlet UIView *headerView;
@property (nonatomic, weak) IBOutlet UIImageView *headerImage;
@property (nonatomic, weak) IBOutlet UILabel     *headline;
@property (nonatomic, weak) IBOutlet UILabel     *subline;
@property (nonatomic, weak) IBOutlet UILabel     *updated;
@property (nonatomic, weak) IBOutlet UILabel     *primaryTag;
@property (nonatomic, weak) IBOutlet UIView      *primaryTagView;

@property (weak, nonatomic) IBOutlet UIView *webviewContainer;

@property (strong, nonatomic) WKWebView *webview;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintWebviewHeight;

@property (nonatomic, strong) CFArticleModel *articleModel;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic) BOOL isAlreadyUpdated;

@end

@implementation KCArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //Styling
    _headline.textColor     = [UIColor whiteColor];
    _headline.font          = [UIFont kc_HeavyFontWithSize:23.0f];
    
    _subline.textColor = [UIColor whiteColor];
    _subline.font      = [UIFont kc_RegularFontWithSize:15.0f];

    _updated.textColor = [UIColor whiteColor];
    _updated.font      = [UIFont kc_LightFontWithSize:13.0f];

    _primaryTag.textColor       = [UIColor whiteColor];
    _primaryTag.font            = [UIFont kc_RegularFontWithSize:15.0f];
    _primaryTag.backgroundColor = [UIColor clearColor];

    _primaryTagView.backgroundColor = [UIColor kc_PrimaryTagColour];
    
    //Webview
    self.webview = [[WKWebView alloc] init];
    [self.webviewContainer addSubview:self.webview];
    
    //Add observer for loading
    [self.webview addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:nil];
    
    self.webview.keepCenter.equal = 0.5;
    self.webview.keepSizeTo(self.webviewContainer).equal = 1;
    
    self.webview.scrollView.scrollEnabled = NO;
    
    self.isAlreadyUpdated = NO;
}

-(void) viewWillAppear:(BOOL)animated
{

}

-(void) viewDidLayoutSubviews
{
    if (!self.isAlreadyUpdated)
    {
        self.isAlreadyUpdated = YES;
        [self updateText];
        [self updateImage];
    }
}

-(void) viewWillDisappear:(BOOL)animated
{
    [self.webview removeObserver:self forKeyPath:@"loading"];
}

//instances
- (void)updateText
{
    self.headline.text   = self.articleModel.headline;
    self.subline.text    = self.articleModel.byline;
    self.updated.text    = self.articleModel.publishDate;
    self.primaryTag.text = [[self.articleModel.tags firstObject] uppercaseString];
    
    NSString *htmlString = self.articleModel.body;
    //Check if it's html or not
    if (!([htmlString containsString:@"<html>"]||[htmlString containsString:@"<p>"]))
    {
        NSError  *error;
        htmlString = [MMMarkdown HTMLStringWithMarkdown:htmlString error:&error];
    }

    //Handle contentful images
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"//images.contentful.com" withString:@"https://images.contentful.com"];
    
    [self.webview loadHTMLString:htmlString baseURL:[[NSURL alloc] initWithString:@""]];
//    [self.webview loadRequest:[[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:@"http://www.cnn.com"]]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString: @"loading"]) {

        [self.webview evaluateJavaScript:@"document.height" completionHandler:^(NSNumber* result, NSError * _Nullable  error) {
            if (error == nil)
            {
                //Disregard the result, as we are just using side-effect of evaluateJavaScript
                float contentHeight = self.webview.scrollView.contentSize.height;
                
                if (contentHeight > 0)
                {
                    self.constraintWebviewHeight.constant = contentHeight;
                }

                [self.view setNeedsLayout];
            }
        }];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Update

- (void)updateWithModel:(CFArticleModel *)articleModel {
    //declaring global variable
    self.articleModel = articleModel;
}

- (void)updateImage {
    
    NSURL *imageURL = [NSURL URLWithString:[self.articleModel.thumnailURLs firstObject]];
    [self.headerImage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"image_placeholder"]];
}

#pragma mark - Button actions
- (IBAction)onCloseButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
