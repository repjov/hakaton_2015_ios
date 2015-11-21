//
//  StoreData.m
//  ChildTracker
//
//  Created by dev on 21/11/15.
//  Copyright © 2015 Lodossteam. All rights reserved.
//

#import "StoreData.h"

@implementation StoreData

+ (BOOL)isHaveTokenAlready
{
    NSString *userListFilename = [StoreData pathToFileWithStore];
    NSMutableArray *usersArray = [NSMutableArray arrayWithContentsOfFile:userListFilename];
    NSString *token = [usersArray firstObject];
    BOOL isTokenSaved = (!([NSString isNilOrEmpty:token]));
    
    return isTokenSaved;
}

+ (void)saveToken:(NSString *)token
//+ (void)saveToFile:(NSMutableArray *)tokenArray
{
    if (token == nil) return;
    
    NSArray *tokeArray = [NSArray arrayWithObject:token];
    NSString *userListFilename = [StoreData pathToFileWithStore];
    [tokeArray writeToFile:userListFilename atomically:YES];
}

+ (NSString *)loadToken
{
    NSString *userListFilename = [StoreData pathToFileWithStore];
    NSMutableArray *usersArray = [NSMutableArray arrayWithContentsOfFile:userListFilename];
    NSString *token = [usersArray firstObject];
    
    return token;
}

+ (void)deleteSavedToken
{
    NSError *error;
    if(![[NSFileManager defaultManager] removeItemAtPath:[StoreData pathToFileWithStore] error:&error])
    {
        //TODO: Handle/Log error
    }
}

+ (NSString *)pathToFileWithStore
{
    NSString *const tokenFileName = @"token.plist";
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *userListFilename = [ documentsPath stringByAppendingPathComponent:tokenFileName];
    
    return userListFilename;
}

@end
