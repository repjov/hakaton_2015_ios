//
//  CurrentUserSession.h
//  Instasound
//
//  Created by dev on 17/11/15.
//  Copyright © 2015 Lodossteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Consts.h"

@interface CurrentUserSession : NSObject

SINGLETON_DEF

- (void)startSessionWithToken:(NSString *)token;
- (void)resetSession;

@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *email;

@end
