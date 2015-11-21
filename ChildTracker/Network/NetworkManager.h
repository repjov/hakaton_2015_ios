//
//  NetworkManager.h
//  Instasound
//
//  Created by dev on 17/11/15.
//  Copyright © 2015 Lodossteam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

+ (void)registerUser:(NSString *)email
             success:(void (^)(NSData *data))successBlock
               error:(void (^)(NSString *localizedDescriptionText))errorBlock
             cleanup:(void (^)())cleanupBlock;

+ (void)getListsForToken:(NSString *)token
         success:(void (^)(NSData *data))successBlock
           error:(void (^)(NSString *localizedDescriptionText))errorBlock
         cleanup:(void (^)())cleanupBlock;

+ (void)getVideosForToken:(NSString *)token
                   listID:(NSString *)listID
                  success:(void (^)(NSData *data))successBlock
                    error:(void (^)(NSString *localizedDescriptionText))errorBlock
                  cleanup:(void (^)())cleanupBlock;

+ (void)getControlForToken:(NSString *)token
                   success:(void (^)(NSData *data))successBlock
                     error:(void (^)(NSString *localizedDescriptionText))errorBlock
                   cleanup:(void (^)())cleanupBlock;

@end
