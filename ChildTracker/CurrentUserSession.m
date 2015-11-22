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

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imageCache = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)startSessionWithToken:(NSString *)token
{
    self.token = token;
}

- (void)resetSession
{
    self.token = nil;
}

- (BOOL)isHaveImageForURL:(NSString *)url
{
    UIImage *image = [self.imageCache objectForKey:url];
    
    if (image != nil)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (UIImage *)imageForURL:(NSString *)url
{
    if (url == nil) nil;
    
    return [self.imageCache objectForKey:url];
}

- (void)addImage:(UIImage *)image forURL:(NSString *)url
{
    if (image == nil) return;
    if (url == nil) return;
    
    [self.imageCache setObject:image forKey:url];
}

@end
