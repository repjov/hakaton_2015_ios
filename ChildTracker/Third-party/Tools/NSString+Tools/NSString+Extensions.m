//
//  NSString+Extensions.m
//  Unleashed
//
//  Created on 5/24/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "NSString+Extensions.h"

@implementation NSString (Extensions)

+ (BOOL)isNilOrEmpty:(NSString *)string
{
    return (![string isKindOfClass:[NSString class]] || string == nil || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0);
}

+ (NSString *)stringForInvalidString:(NSString *)string
{
    if ([NSString isNilOrEmpty:string])
    {
        return @"";
    }
    return string;
}

+ (NSString *)wrappedString:(NSString *)string defaultValue:(NSString *)defaultValue
{
    NSString *result = [NSString stringForInvalidString:string];
    if (result.length == 0)
    {
        return defaultValue;
    }
    return result;
}

@end
