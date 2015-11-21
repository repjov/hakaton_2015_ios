//
//  CurrentUserSession.m
//  Instasound
//
//  Created by dev on 17/11/15.
//  Copyright © 2015 Lodossteam. All rights reserved.
//

#import "CurrentUserSession.h"

@implementation CurrentUserSession

SINGLETON_IMP

- (void)startSessionWithToken:(NSString *)token
{
    self.token = token;
}

- (void)resetSession
{
    self.token = nil;
}

@end
