//
//  KCAPIClient.h
//  Kapacino
//
//  Created by Igor Czarev on 4/2/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KCUser.h"
#import <Firebase/Firebase.h>

@interface KCAPIClient : NSObject

@property (strong, nonatomic) NSString *currentUserID;

+ (instancetype)sharedClient;

- (void)loginUserWithProvider:(NSString *)provide
                        token:(NSString *)token
                      success:(void (^)(FAuthData *authData))success
                      failure:(void (^)(NSError *error))failure;

- (void)loginUserWithEmail:(NSString *)email
                  password:(NSString *)password
                   success:(void (^)(FAuthData *authData))success
                   failure:(void (^)(NSError *error))failure;

- (void)createUserWithEmail:(NSString *)email
                  password:(NSString *)password
                   success:(void (^)(Firebase *userRef))success
                   failure:(void (^)(NSError *error))failure;


- (void)getUserByID:(NSString *)uID
            success:(void (^)(NSDictionary *userData, BOOL completeUserProfile))success
            failure:(void (^)(NSError *error))failure;

- (void)createUserWithID:(NSString *)uID
                userInfo:(NSDictionary *)userInfo
                 success:(void (^)( Firebase *userRef))success
                 failure:(void (^)(NSError *error))failure;

- (void)updateUserWithID:(NSString *)uID
                userInfo:(NSDictionary *)userInfo
                 success:(void (^)( Firebase *userRef))success
                 failure:(void (^)(NSError *error))failure;

@end
