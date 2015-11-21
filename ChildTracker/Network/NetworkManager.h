//
//  NetworkManager.h
//  Instasound
//
//  Created by dev on 17/11/15.
//  Copyright © 2015 Lodossteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserToRegister.h"

@interface NetworkManager : NSObject

+ (void)signInUser:(NSString *)login
          password:(NSString *)password
           success:(void (^)(NSString *accessToken))successBlock
             error:(void (^)(NSString *localizedDescriptionText))errorBlock
           cleanup:(void (^)())cleanupBlock;

+ (void)signInWithFacebookUserID:(NSString *)userId
                   facebookToken:(NSString *)facebookToken
                         success:(void (^)(NSString *accessToken))successBlock
                           error:(void (^)(NSString *localizedDescriptionText))errorBlock
                         cleanup:(void (^)())cleanupBlock;

+ (void)registerUser:(UserToRegister *)user
             success:(void (^)(NSString *accessToken))successBlock
               error:(void (^)(NSString *localizedDescriptionText))errorBlock
             cleanup:(void (^)())cleanupBlock;

+ (void)registerViaFacebookUser:(UserToRegister *)user
                      FacebokID:(NSString *)facebookID
                        success:(void (^)(NSString *accessToken))successBlock
                          error:(void (^)(NSString *localizedDescriptionText))errorBlock
                        cleanup:(void (^)())cleanupBlock;

@end
