//
//  NetworkRequestSender.h
//  Instasound
//
//  Created by dev on 16/11/15.
//  Copyright © 2015 Lodossteam. All rights reserved.
//

#import <Foundation/Foundation.h>

/* Low Layer Network Class*/

@interface NetworkRequestSender : NSObject

+ (void)sendToEndpoint:(NSString *)endpoint
                  body:(NSString *)body
                method:(NSString *)method
               success:(void (^)(NSData *data))successBlock
                 error:(void (^)(NSString *localizedDescriptionText))error
               cleanup:(void (^)())cleanup;

@end
