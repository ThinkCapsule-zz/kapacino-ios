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

@synthesize currentUserID = _currentUserID;

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

- (NSString *)currentUserID {
    if (!_currentUserID) {
        _currentUserID = [[NSUserDefaults standardUserDefaults]objectForKey:@"currentUserID"];
    }
    return _currentUserID;
}

- (void)setCurrentUserID:(NSString *)currentUserID {
    [[NSUserDefaults standardUserDefaults] setValue:currentUserID forKey:@"currentUserID"];
}


- (void)loginUserWithProvider:(NSString *)provide token:(NSString *)token success:(void (^)(FAuthData *))success failure:(void (^)(NSError *))failure {
    
    [self.baseReference authWithOAuthProvider:provide token:token withCompletionBlock:^(NSError *error, FAuthData *authData) {
        if (error) {
            failure(error);
        } else {
            if (success) {
                success (authData);
            }
        }
    }];
}

- (void)loginUserWithEmail:(NSString *)email password:(NSString *)password success:(void (^)(FAuthData *))success failure:(void (^)(NSError *))failure {
    
    [self.baseReference authUser:email password:password withCompletionBlock:^(NSError *error, FAuthData *authData) {
        if (error) {
            failure (error);
        } else {
            if (success) {
                success (authData);
            }
        }
    }];
}

- (void)createUserWithEmail:(NSString *)email password:(NSString *)password success:(void (^)(Firebase *))success failure:(void (^)(NSError *))failure {
    [self.baseReference createUser:email password:password withValueCompletionBlock:^(NSError *error, NSDictionary *result) {
        NSString *uID = [result objectForKey:@"uid"];
        NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
        [userInfo setObject:email forKey:@"Email"];
        [self createUserWithID:uID userInfo:userInfo success:^(Firebase *userRef) {
            self.currentUserID = uID;
            if (success) {
                success (userRef);
            }
        } failure:^(NSError *error) {
            failure (error);
        }];
    }];
}
- (void)getUserByID:(NSString *)uID success:(void (^)(NSDictionary *, bool))success failure:(void (^)(NSError *))failure {
    Firebase *getUser = [self.userReference childByAppendingPath:uID];
    
    [getUser observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        BOOL completeUserProfile = nil;
        self.currentUserID = uID;
        if (snapshot.value != [NSNull null]) {
            completeUserProfile = [snapshot.value objectForKey:@"complete"];
            success(snapshot.value, completeUserProfile);
        } else {
            if (success) {
                success(snapshot.value, completeUserProfile);
            }
        }
    }];
}

- (void)createUserWithID:(NSString *)uID userInfo:(NSDictionary *)userInfo success:(void (^)( Firebase *))success failure:(void (^)(NSError *))failure {
    Firebase *createUser = [self.userReference childByAppendingPath:uID];
    [createUser setValue:userInfo withCompletionBlock:^(NSError *error, Firebase *ref) {
        if (error) {
            failure (error);
        } else {
            self.currentUserID = uID;
            if (success) {
                success (ref);
            }
        }
    }];
}

- (void)updateUserWithID:(NSString *)uID userInfo:(NSDictionary *)userInfo success:(void (^)(Firebase *))success failure:(void (^)(NSError *))failure {
    Firebase *updateUser = [self.userReference childByAppendingPath:uID];
    [updateUser updateChildValues:userInfo withCompletionBlock:^(NSError *error, Firebase *ref) {
        if (error) {
            failure (error);
        } else {
            if (success) {
                success (ref);
            }
        }
    }];
}

@end
