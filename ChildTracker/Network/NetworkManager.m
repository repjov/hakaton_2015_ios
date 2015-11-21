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

+ (void)registerUser:(NSString *)email
             success:(void (^)(NSDictionary *resonseDict))successBlock
               error:(void (^)(NSString *localizedDescriptionText))errorBlock
             cleanup:(void (^)())cleanupBlock

{
    NSAssert((email != nil), kAssertMessageFormat, __PRETTY_FUNCTION__, @"email");
    
    if (email == nil) return;
    
    NSString *body;
    body = [NSString stringWithFormat: @"{\n \"email\": \"%@\"}", email];
    
    [NetworkRequestSender sendToEndpoint:kRegisterEnpoint body:body success:successBlock error:errorBlock cleanup:cleanupBlock];
}

+ (void)sendCode:(NSString *)code
             success:(void (^)(NSString *accessToken))successBlock
               error:(void (^)(NSString *localizedDescriptionText))errorBlock
             cleanup:(void (^)())cleanupBlock

{
    NSAssert((code != nil), kAssertMessageFormat, __PRETTY_FUNCTION__, @"email");
    
    if (code == nil) return;
    
    NSString *body;
    body = [NSString stringWithFormat: @"{\n \"code\": \"%@\"}", code];
    
    [NetworkRequestSender sendToEndpoint:kRegisterEnpoint body:body success:^(NSDictionary *resonseDict) {
        NSString *token = resonseDict[@"token"];
        if (token != nil)
        {
            successBlock(token);
        }
        else
        {
            errorBlock(@"Session token not found in aswer");
        }
    } error:errorBlock cleanup:cleanupBlock];
}



@end
