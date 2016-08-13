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

@property (nonatomic, strong) UIButton     *closeButton;

@property (nonatomic, strong) UITextView   *textArea;
@property (nonatomic, strong) UIScrollView *scrollView;

/* Header */
@property (nonatomic, strong) UIView      *headerView;
@property (nonatomic, strong) UIImageView *headerImage;
@property (nonatomic, strong) UILabel     *headline;
@property (nonatomic, strong) UILabel     *subline;
@property (nonatomic, strong) UILabel     *updated;
@property (nonatomic, strong) UILabel     *primaryTag;
@property (nonatomic, strong) UIView      *primaryTagView;

@property (nonatomic, strong) WKWebView *webview;

@property (nonatomic, strong) CFArticleModel *articleModel;

@end

@implementation KCArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self setupDetailView];
    [self setupConstraints];

    [self updateText];
    
}

//instances
- (void)updateText
{
    self.headline.text   = self.articleModel.headline;
    self.subline.text    = self.articleModel.byline;
    self.updated.text    = self.articleModel.publishDate;
    self.primaryTag.text = [[self.articleModel.tags firstObject] uppercaseString];
//    self.textArea.text   = self.articleModel.body;
    
    NSString *htmlString = self.articleModel.body;
    //Check if it's html or not
    if (!([htmlString containsString:@"<html>"]||[htmlString containsString:@"<p>"]))
    {
        NSError  *error;
        htmlString = [MMMarkdown HTMLStringWithMarkdown:htmlString error:&error];
    }

    //Handle contentful images
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"//images.contentful.com" withString:@"https://images.contentful.com"];
    
    [self.webview loadHTMLString:htmlString baseURL:[[NSURL alloc] initWithString:@"www.google.com"]];
}


#pragma mark - Update

- (void)updateWithModel:(CFArticleModel *)articleModel {
    //declaring global variable
    self.articleModel = articleModel;
    
    [self updateImage];
}

- (void)updateImage {
    
    NSURL *imageURL = [NSURL URLWithString:[self.articleModel.thumnailURLs firstObject]];
    [self.headerImage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"image_placeholder"]];

}



#pragma mark - Setup

- (void)setupDetailView {
    
    /* Header */
    [self.headerView addSubview:self.headerImage];
    [self.headerView addSubview:self.headline];
    [self.headerView addSubview:self.subline];
    [self.headerView addSubview:self.updated];
    
    /* Primary tag */
    [self.primaryTagView addSubview:self.primaryTag];
    [self.headerView addSubview:self.primaryTagView];
    
    /* Content */
    [self.scrollView addSubview:self.headerView];
    [self.scrollView addSubview:self.webview];
    
    /* View */
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.closeButton];
    
}

#pragma mark - Constraints
- (void)setupConstraints {
    
    self.closeButton.keepTopInset.equal                     = 25;
    self.closeButton.keepLeftInset.equal                    = 10;

    self.scrollView.keepHorizontalInsets.equal              = 0;
    self.scrollView.keepVerticalInsets.equal                = 0;

    /* Header */
    self.headerView.keepTopAlignTo(self.scrollView).equal   = 0;
    self.headerView.keepWidth.equal                         = self.view.frame.size.width;
    self.headerView.keepHeight.equal                        = self.view.frame.size.height/2;

    self.headerImage.keepInsets.equal                       = 0;

    self.headline.keepBottomInset.equal                     = 150;
    self.headline.keepHorizontalInsets.equal                = 15;

    self.subline.keepTopOffsetTo(self.headline).equal       = 10;
    self.subline.keepHorizontalInsets.equal                 = 15;

    self.updated.keepTopOffsetTo(self.subline).equal        = 10;
    self.updated.keepHorizontalInsets.equal                 = 15;

    self.primaryTagView.keepTopOffsetTo(self.updated).equal = 10;
    self.primaryTagView.keepLeftInset.equal                 = 15;

    self.primaryTag.keepVerticalInsets.equal                = 2;
    self.primaryTag.keepHorizontalInsets.equal              = 5;

    /* Content */
    self.webview.keepTopOffsetTo(self.headerView).equal    = 0;
    self.webview.keepWidthTo(self.scrollView).equal        = 1;
//    self.webview.keepBottomInset.equal                     = 0;
    //TODO: How do I get the height of the webview contents?
    self.webview.keepHeight.equal = 3000;
}

#pragma mark - Getter

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton       = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"close_button_pink"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(dismissDetail) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView                 = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.contentSize     = self.view.frame.size;
        _scrollView.bounces         = NO;
    }
    return _scrollView;
}

- (UITextView *)textArea {

    
    if (!_textArea) {
        _textArea               = [[UITextView alloc] initWithFrame:self.view.frame];
        _textArea.selectable    = NO;
        _textArea.editable      = NO;
        _textArea.scrollEnabled = NO;
        _textArea.font          = [UIFont kc_RegularFontWithSize:16.0f];
    
    }
    return _textArea;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView                 = [[UIView alloc] init];
        _headerView.backgroundColor = [UIColor grayColor];
    }
    return _headerView;
}

- (UIImageView *)headerImage {
    
    if (!_headerImage) {
        _headerImage             = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellBackground"]];
        _headerImage.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headerImage;
}

- (UILabel *)headline {
    if (!_headline) {
        _headline               = [[UILabel alloc] init];
        _headline.textColor     = [UIColor whiteColor];
        _headline.font          = [UIFont kc_HeavyFontWithSize:23.0f];
        _headline.lineBreakMode = NSLineBreakByWordWrapping;
        _headline.numberOfLines = 0;
    }
    return _headline;
}

- (UILabel *)subline {
    if (!_subline) {
        _subline           = [[UILabel alloc] init];
        _subline.textColor = [UIColor whiteColor];
        _subline.font      = [UIFont kc_RegularFontWithSize:15.0f];
    }
    return _subline;
}

- (UILabel *)updated {
    if (!_updated) {
        _updated           = [[UILabel alloc] init];
        _updated.textColor = [UIColor whiteColor];
        _updated.font      = [UIFont kc_LightFontWithSize:13.0f];
    }
    return _updated;
}

- (UILabel *)primaryTag {
    if (!_primaryTag) {
        _primaryTag                 = [[UILabel alloc] init];
        _primaryTag.textColor       = [UIColor whiteColor];
        _primaryTag.font            = [UIFont kc_RegularFontWithSize:15.0f];
        _primaryTag.backgroundColor = [UIColor clearColor];
    }
    return _primaryTag;
    
}

- (UIView *)primaryTagView {
    if (!_primaryTagView) {
        _primaryTagView                 = [[UIView alloc] init];
        _primaryTagView.backgroundColor = [UIColor kc_PrimaryTagColour];
    }
    return _primaryTagView;
}

- (WKWebView *)webview {
    if (!_webview) {
        _webview = [[WKWebView alloc] initWithFrame:self.view.frame];
        _webview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _webview.scrollView.scrollEnabled = NO;
    }
    return _webview;
}

#pragma mark - Button actions

- (void)dismissDetail {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
