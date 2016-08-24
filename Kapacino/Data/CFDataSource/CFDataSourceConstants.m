//
//  CFDataSourceConstants.m
//  Kapacino
//
//  Created by Alan Hsu on 2015-11-26.
//  Copyright © 2015 Alan Hsu. All rights reserved.
//

#import "CFDataSourceConstants.h"

/** Tokens **/
NSString* const CFPreviewToken    = @"ea40f4d68e1983a625ac5330daaaaee3befeda5a26dc4da674ccee3b5dec4037";
NSString* const CFProductionToken = @"15fb8db3a77203b19bacfd6589be0cf3630c3d7ef3c035049785bf2fc43c8c42";

/** URLs **/
NSString* const CFBasePreviewURL    = @"https://preview.contentful.com";
NSString* const CFBaseProductionURL = @"https://cdn.contentful.com";
NSString* const CFBaseAssetURL      = @"https://images.contentful.com";

/** Space **/
NSString* const CFSpaceIdentifier = @"1oq1lgnwupsh";

/** Content Type Identifier **/
NSString* const CFArticleTypeIdentifier  = @"nuHecKQQjmQKgKwu6osYQ";
NSString* const CFBlogTypeIdentifier     = @"1qeOXb11aEYciiYEGoS06Y";
NSString* const CFVideoTypeIdentifier    = @"2eL4rLPvkQ0qCWQsooksuK";
NSString* const CFListingsTypeIdentifier = @"12tqAiosJMaEKMk6682esG";
NSString* const CFPlacesTypeIdentifier   = @"12tqAiosJMaEKMk6682esG"; // same as listing for now
NSString* const CFEventsTypeIdentifier   = @"events"; // same as listing for now

/** Directories **/
NSString* const CFContentSpacesDir  = @"/spaces";
NSString* const CFContentEntriesDir = @"/entries";
NSString* const CFContentAssetsDir  = @"/assets";

/** Queries **/
NSString* const CFContentTokenQuery = @"access_token";
NSString* const CFContentTypeQuery  = @"content_type";