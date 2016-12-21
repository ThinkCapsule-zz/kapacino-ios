//
//  KCAPIClient.m
//  Kapacino
//
//  Created by Igor Czarev on 4/2/16.
//  Copyright © 2016 Alan Hsu. All rights reserved.
//

#import "KCAPIClient.h"
#import "UserInfo.h"
@import Firebase;

static NSString *const KCBaseUrlString = @"radiant-inferno-4979.firebaseIO.com";
static NSString *const KCUsersPath= @"users";
static NSString *const KCCoursesPath= @"courses";
static NSString *const KCMarksPath= @"marks";

//static NSString *const KCCoursesPath= @"marks";

static KCAPIClient *__sharedClient = nil;

@interface KCAPIClient ()

@property (strong, nonatomic) FIRDatabaseReference *baseReference;
@property (strong, nonatomic) FIRDatabaseReference *usersReference;
@property (strong, nonatomic) FIRDatabaseReference *coursesReference;
@property (strong, nonatomic) FIRDatabaseReference *marksReference;

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
    __sharedClient.baseReference = [[FIRDatabase database] reference];
    __sharedClient.usersReference = [__sharedClient.baseReference child:KCUsersPath];
    __sharedClient.coursesReference = [__sharedClient.baseReference child:KCCoursesPath];
    __sharedClient.marksReference = [__sharedClient.baseReference child:KCMarksPath];
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


//- (void)loginUserWithProvider:(NSString *)provide token:(NSString *)token success:(void (^)(FAuthData *))success failure:(void (^)(NSError *))failure {
//    
//    [self.baseReference authWithOAuthProvider:provide token:token withCompletionBlock:^(NSError *error, FAuthData *authData) {
//        if (error) {
//            failure(error);
//        } else {
//            if (success) {
//                success (authData);
//            }
//        }
//    }];
//}
//
//- (void)loginUserWithEmail:(NSString *)email password:(NSString *)password success:(void (^)(FAuthData *))success failure:(void (^)(NSError *))failure {
//    
//    [[FIRAuth auth] signInWithEmail:_emailField.text
//                           password:_passwordField.text
//                         completion:^(FIRUser *user, NSError *error) {
////                             [self hideSpinner:^{
////                                 if (error) {
////                                     [self showMessagePrompt:error.localizedDescription];
////                                     return;
////                                 }
////                                 [[[_ref child:@"users"] child:user.uid]
////                                  observeEventType:FIRDataEventTypeValue
////                                  withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
////                                      if (![snapshot exists]) {
////                                          [self promptForNewUserName:user];
////                                      } else {
////                                          [self performSegueWithIdentifier:@"signIn"
////                                                                    sender:nil];
////                                      }
////                                  }];
////                             }];
//                         }];
//
////    [self.baseReference authUser:email password:password withCompletionBlock:^(NSError *error, FAuthData *authData) {
////        if (error) {
////            failure (error);
////        } else {
////            if (success) {
////                success (authData);
////            }
////        }
////    }];
//}
//
//- (void)createUserWithEmail:(NSString *)email password:(NSString *)password success:(void (^)(Firebase *))success failure:(void (^)(NSError *))failure {
//    [self.baseReference createUser:email password:password withValueCompletionBlock:^(NSError *error, NSDictionary *result) {
//        NSString *uID = [result objectForKey:@"uid"];
//        NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
//        [userInfo setObject:email forKey:@"Email"];
//        [self createUserWithID:uID userInfo:userInfo success:^(Firebase *userRef) {
//            self.currentUserID = uID;
//            if (success) {
//                success (userRef);
//            }
//        } failure:^(NSError *error) {
//            failure (error);
//        }];
//    }];
//}
//- (void)getUserByID:(NSString *)uID success:(void (^)(NSDictionary *, bool))success failure:(void (^)(NSError *))failure {
//    Firebase *getUser = [self.userReference childByAppendingPath:uID];
//    
//    [getUser observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
//        BOOL completeUserProfile = nil;
//        self.currentUserID = uID;
//        if (snapshot.value != [NSNull null]) {
//            completeUserProfile = [snapshot.value objectForKey:@"complete"];
//            success(snapshot.value, completeUserProfile);
//        } else {
//            if (success) {
//                success(snapshot.value, completeUserProfile);
//            }
//        }
//    }];
//}
//
//- (void)createUserWithID:(NSString *)uID userInfo:(NSDictionary *)userInfo success:(void (^)( Firebase *))success failure:(void (^)(NSError *))failure {
//    Firebase *createUser = [self.userReference childByAppendingPath:uID];
//    [createUser setValue:userInfo withCompletionBlock:^(NSError *error, Firebase *ref) {
//        if (error) {
//            failure (error);
//        } else {
//            self.currentUserID = uID;
//            if (success) {
//                success (ref);
//            }
//        }
//    }];
//}
//
//- (void)updateUserWithID:(NSString *)uID userInfo:(NSDictionary *)userInfo success:(void (^)(Firebase *))success failure:(void (^)(NSError *))failure {
//    Firebase *updateUser = [self.userReference childByAppendingPath:uID];
//    [updateUser updateChildValues:userInfo withCompletionBlock:^(NSError *error, Firebase *ref) {
//        if (error) {
//            failure (error);
//        } else {
//            if (success) {
//                success (ref);
//            }
//        }
//    }];
//}

-(FIRDatabaseReference *)baseReference
{
    return _baseReference;
}

-(FIRDatabaseReference *)usersReference
{
    return _usersReference;
}

-(FIRDatabaseReference *)coursesReference
{
    return _coursesReference;
}

-(FIRDatabaseReference *)marksReference
{
    return _marksReference;
}

-(FIRDatabaseReference *)coursesReferenceForCurrentUser
{
    NSString *userId = [FIRAuth auth].currentUser.uid;
    return userId != nil ? [[self coursesReference] child:userId] : nil;
}

-(FIRDatabaseReference *)marksReferenceForCurrentUser
{
    NSString *userId = [FIRAuth auth].currentUser.uid;
    return userId != nil ? [[self marksReference] child:userId] : nil;
}

-(FIRDatabaseReference *) usersReferenceForCurrentUser
{
    NSString *userId = [FIRAuth auth].currentUser.uid;
    return userId != nil ? [[self usersReference] child:userId] : nil;
}

-(void)checkCompletionStatusWithCompletionHandler:(void (^)(BOOL))completionHandler
{
    [[self usersReferenceForCurrentUser] observeEventType:FIRDataEventTypeValue
                                                withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
                                                    UserInfo* userInfo = [[UserInfo alloc] init:snapshot];
                                                    completionHandler(userInfo.isComplete);
//                                                    if (snapshot.value != [NSNull null]) {
//                                                        BOOL isComplete = [snapshot.value objectForKey:@"complete"];
//                                                        completionHandler(isComplete);
//                                                    } else {
//                                                        completionHandler(false);
//                                                    }
                                                }];
}

@end
