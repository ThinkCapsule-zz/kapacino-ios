//
//  KCAPIClient.h
//  Kapacino
//
//  Created by Igor Czarev on 4/2/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FirebaseAuth/FirebaseAuth.h>

@import Firebase;

@interface KCAPIClient : NSObject

@property (strong, nonatomic) NSString *currentUserID;

+ (instancetype)sharedClient;

-(FIRDatabaseReference*) baseReference;
-(FIRDatabaseReference*) usersReference;
-(FIRDatabaseReference*) coursesReference;
-(FIRDatabaseReference*) marksReference;

-(FIRDatabaseReference *)coursesReferenceForCurrentUser;
-(FIRDatabaseReference *)marksReferenceForCurrentUser;
-(FIRDatabaseReference *) usersReferenceForCurrentUser;

-(void)checkCompletionStatusWithCompletionHandler:(void (^)(BOOL))completionHandler;
//- (void)loginUserWithProvider:(NSString *)provide
//                        token:(NSString *)token
//                        completionHandler:(void (^)(FIRUser *user, NSError *error)) completionHandler;
//
//- (void)loginUserWithEmail:(NSString *)email
//                  password:(NSString *)password
//                   completionHandler:(void (^)(FIRUser *user, NSError *error)) completionHandler;
//
//- (void)createUserWithEmail:(NSString *)email
//                  password:(NSString *)password
//                    completionHandler:(void (^)(FIRUser *user, NSError *error)) completionHandler;
//
//
//- (void)getUserByID:(NSString *)uID
//            completionHandler:(void (^)(FIRUser *user, NSError *error)) completionHandler;
//
//- (void)createUserWithID:(NSString *)uID
//             completionHandler:(void (^)(FIRUser *user, NSError *error)) completionHandler;
//
//- (void)updateUserWithID:(NSString *)uID
//            completionHandler:(void (^)(FIRUser *user, NSError *error)) completionHandler;

@end
