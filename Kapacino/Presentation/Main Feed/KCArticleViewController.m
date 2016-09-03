//
//  KCArticleViewController.m
//  Kapacino
//
//  Created by Ivan Cheung on 2016-08-31.
//  Copyright © 2016 ThinkCapsule. All rights reserved.
//

#import "KCArticleViewController.h"
#import "KCFeedCell.h"
#import "CFArticleModel.h"

@interface KCArticleViewController ()

@end

@implementation KCArticleViewController

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
    return CFContentType_Article;
}

-(void) updateCell:(KCFeedCell*)cell forContentModel:(NSObject *)contentModel
{
    CFArticleModel* model = (CFArticleModel*) contentModel;
    [cell updateWithHeadline:model.headline andByline:model.byline andDateLine:model.publishDate andTags:model.tags andThumbnails:model.thumnailURLs];
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
