//
//  NSString+Extensions.h
//  Unleashed
//
//  Created on 5/24/12.
//  Copyright (c) 2012. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extensions)

+ (BOOL)isNilOrEmpty:(NSString *)string;
+ (NSString *)stringForInvalidString:(NSString *)string;
+ (NSString *)wrappedString:(NSString *)string defaultValue:(NSString *)defaultValue;

@end
