//
//  NetworkManager.m
//  Instasound
//
//  Created by dev on 17/11/15.
//  Copyright © 2015 Lodossteam. All rights reserved.
//

#import "NetworkManager.h"
#import "NetworkRequestSender.h"
#import "Consts.h"

@implementation NetworkManager

+ (void)registerUser:(NSString *)user
             success:(void (^)(NSString *accessToken))successBlock
               error:(void (^)(NSString *localizedDescriptionText))errorBlock
             cleanup:(void (^)())cleanupBlock

{
    NSAssert((user != nil), kAssertMessageFormat, __PRETTY_FUNCTION__, @"user");
    
    if (user == nil) return;
    
    NSString *body;
//    body = [NSString stringWithFormat: @"{\n \"first_name\": \"%@\",\n  \"last_name\": \"%@\",\n  \"full_name\": \"%@\",\n  \"email\": \"%@\",\n  \"password\": \"%@\",\n  \"birth\": \"%@\",\n  \"gender\": \"%@\"}", user.first_name, user.last_name, user.full_name, user.email, user.password, user.birth, user.gender];
    
    [NetworkRequestSender sendToEndpoint:kSignUpEnpoint body:body success:^(NSDictionary *resonseDict) {
        NSString *token = resonseDict[@"accessToken"];
        if (token != nil)
        {
            successBlock(token);
        }
        else
        {
#warning Move constant outside
            errorBlock(@"Session token not found in aswer");
        }
    } error:errorBlock cleanup:cleanupBlock];
}

+ (void)registerViaFacebookUser:(NSString *)user
                      FacebokID:(NSString *)facebookID
                        success:(void (^)(NSString *accessToken))successBlock
                          error:(void (^)(NSString *localizedDescriptionText))errorBlock
                        cleanup:(void (^)())cleanupBlock;
{
    NSAssert((user != nil), kAssertMessageFormat, __PRETTY_FUNCTION__, @"user");
    NSAssert((facebookID != nil), kAssertMessageFormat, __PRETTY_FUNCTION__, @"facebookID");
    
    if (user == nil) return;
    if (facebookID == nil) return;
    
    NSString *body;
//    body = [NSString stringWithFormat: @"{\n \"first_name\": \"%@\",\n  \"last_name\": \"%@\",\n  \"full_name\": \"%@\",\n  \"email\": \"%@\",\n  \"password\": \"%@\",\n  \"birth\": \"%@\",\n  \"gender\": \"%@\",\n  \"facebook_id\": \"%@\"}", user.first_name, user.last_name, user.full_name, user.email, user.password, user.birth, user.gender, facebookID];
    
    [NetworkRequestSender sendToEndpoint:kSignUpEnpoint body:body success:^(NSDictionary *resonseDict) {
        NSString *token = resonseDict[@"accessToken"];
        if (token != nil)
        {
            successBlock(token);
        }
        else
        {
#warning Move constant outside
            errorBlock(@"Session token not found in aswer");
        }
    } error:errorBlock cleanup:cleanupBlock];
}

+ (void)signInUser:(NSString *)login
          password:(NSString *)password
           success:(void (^)(NSString *accessToken))successBlock
             error:(void (^)(NSString *localizedDescriptionText))errorBlock
           cleanup:(void (^)())cleanupBlock
{
    NSAssert((login != nil), kAssertMessageFormat, __PRETTY_FUNCTION__, @"login");
    NSAssert((password != nil), kAssertMessageFormat, __PRETTY_FUNCTION__, @"password");
    
    if (login == nil) return;
    if (password == nil) return;
    
    NSString *body;
    body = [NSString stringWithFormat: @"{\n  \"email\": \"%@\",\n  \"password\": \"%@\"\n}", login, password];
    
    [NetworkRequestSender sendToEndpoint:kSignInEnpoint body:body success:^(NSDictionary *resonseDict) {
        NSString *token = resonseDict[@"accessToken"];
        if (token != nil)
        {
            successBlock(token);
        }
        else
        {
#warning Move constant outside
            errorBlock(@"Session token not found in aswer");
        }
    } error:errorBlock cleanup:cleanupBlock];
}

+ (void)signInWithFacebookUserID:(NSString *)userId
          facebookToken:(NSString *)facebookToken
           success:(void (^)(NSString *accessToken))successBlock
             error:(void (^)(NSString *localizedDescriptionText))errorBlock
           cleanup:(void (^)())cleanupBlock
{
    NSAssert((userId != nil), kAssertMessageFormat, __PRETTY_FUNCTION__, @"login");
    NSAssert((facebookToken != nil), kAssertMessageFormat, __PRETTY_FUNCTION__, @"password");
    
    if (userId == nil) return;
    if (facebookToken == nil) return;
    
    NSString *body;
    body = [NSString stringWithFormat: @"{\n  \"accessToken\": \"%@\",\n  \"userID\": \"%@\"\n}", facebookToken, userId];
    
    [NetworkRequestSender sendToEndpoint:kSignAuthFacebookEnpoint body:body success:^(NSDictionary *resonseDict) {
        NSString *token = resonseDict[@"accessToken"];
        if (token != nil)
        {
            successBlock(token);
        }
        else
        {
#warning Move constant outside
            errorBlock(@"Session token not found in aswer");
        }
    } error:errorBlock cleanup:cleanupBlock];
}

+ (void)feedWithSuccess:(void (^)(NSDictionary *resonseDict))successBlock
            error:(void (^)(NSString *localizedDescriptionText))errorBlock
          cleanup:(void (^)())cleanupBlock
{
    NSString *body;
    body = [NSString stringWithFormat: @"{}"];
    
    [NetworkRequestSender sendToEndpoint:kFeedEnpoint body:body success:successBlock error:errorBlock cleanup:cleanupBlock];
}

+ (void)feedWithLimit:(NSUInteger *)limit
                 skip:(NSUInteger *)skip
              success:(void (^)(NSDictionary *resonseDict))successBlock
                error:(void (^)(NSString *localizedDescriptionText))errorBlock
              cleanup:(void (^)())cleanupBlock
{
    
    
    NSString *body;
    body = [NSString stringWithFormat: @"{\n  \"limit\": %tu,\n  \"skip\": %tu\n}", limit, skip];
    
    [NetworkRequestSender sendToEndpoint:kFeedEnpoint body:body success:successBlock error:errorBlock cleanup:cleanupBlock];
}

//2015-11-16 17:23:06.088 Instasound[9334:1442648] Response Body:
//{"status":400,"code":198000,"message":"Some validation rules failed","errors":[{"status":400,"code":198011,"message":"Your password must be at least 5 characters long","timestamp":"2015-11-16 14:11:06.0"}],"timestamp":"2015-11-16 14:11:06.0"}

//2015-11-16 17:24:59.861 Instasound[9404:1447459] Response Body:
//{"accessToken":"FsXimGhvWhg7MYEDUwEof6PL"}

//2015-11-18 22:24:57.192 Instasound[1728:23242] Response Body:
//{"status":400,"code":212011,"message":"There is no such user","timestamp":"2015-11-18 19:11:21.3"}

//{"status":403,"code":212005,"message":"Not valid pair email/password","timestamp":"2015-11-18 19:11:09.9"}

@end
