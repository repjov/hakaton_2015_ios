//
//  StoreData.h
//  ChildTracker
//
//  Created by dev on 21/11/15.
//  Copyright © 2015 Lodossteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Extensions.h"

@interface StoreData : NSObject

+ (BOOL)isHaveTokenAlready;
+ (NSString *)loadToken;
+ (void)saveToken:(NSString *)Token;
+ (void)deleteSavedToken;

@end
