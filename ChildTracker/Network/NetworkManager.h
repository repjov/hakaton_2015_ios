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
             success:(void (^)(NSString *accessToken))successBlock
               error:(void (^)(NSString *localizedDescriptionText))errorBlock
             cleanup:(void (^)())cleanupBlock;

@end
