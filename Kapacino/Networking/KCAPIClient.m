//
//  KCAPIClient.m
//  Kapacino
//
//  Created by Igor Czarev on 4/2/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCAPIClient.h"

static NSString *const KCBaseUrlString = @"luminous-inferno-6931.firebaseio.com";
static NSString *const KCUsersPath= @"users";

static KCAPIClient *__sharedClient = nil;

@interface KCAPIClient ()

@property (strong, nonatomic) Firebase *baseReference;
@property (strong, nonatomic) Firebase *userReference;


@end

@implementation KCAPIClient

+ (instancetype)sharedClient
{
    return __sharedClient;
}

+ (void)initialize
{
    if ([KCAPIClient class] == self) {
        [self initializeWithBaseURL:KCBaseUrlString];
    }
}

+ (void)initializeWithBaseURL:(NSString *)baseURL {
    __sharedClient = [[self alloc] init];
    __sharedClient.baseReference = [[Firebase alloc] initWithUrl:baseURL];
    __sharedClient.userReference = [__sharedClient.baseReference childByAppendingPath:KCUsersPath];
}

- (void)loginUserWithProvider:(NSString *)provide token:(NSString *)token success:(void (^)(FAuthData *))success failure:(void (^)(NSError *))failure {
    
    [self.baseReference authWithOAuthProvider:provide token:token withCompletionBlock:^(NSError *error, FAuthData *authData) {
        if (error) {
            failure(error);
        } else {
            success (authData);
        }
    }];
}

- (void)getUserByID:(NSString *)uID success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure {
    Firebase *getUser = [self.userReference childByAppendingPath:uID];

    [getUser observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if (snapshot.value == [NSNull null] ) {
            failure(nil);
        } else {
            success(snapshot.value);
        }
    }];
}

-(void)createUserWithID:(NSString *)uID success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure {
    
}

@end
