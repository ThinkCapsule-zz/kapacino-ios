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

+ (instancetype)sharedClient;

- (void)loginUserWithProvider:(NSString *)provide
                        token:(NSString *)token
                      success:(void (^)(FAuthData *authData))success
                      failure:(void (^)(NSError *error))failure;

- (void)getUserByID:(NSString *)uID
            success:(void (^)(NSDictionary *userData))success
            failure:(void (^)(NSError *error))failure;

- (void)createUserWithID:(NSString *)uID
                 success:(void (^)(NSDictionary *userData))success
                 failure:(void (^)(NSError *error))failure;
@end
