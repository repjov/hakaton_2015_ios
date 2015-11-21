//
//  NSString+Tools.m
//  FearlessLittle
//
//  Created on 6/3/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "NSString+Tools.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Tools)

- (NSString *)cleanString
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSUInteger)numberOfOccurencesOfSubstring:(NSString *)substring
{
    NSUInteger count = 0;
    NSUInteger length = self.length;
    NSRange range = NSMakeRange(0, length);
    
    while (range.location != NSNotFound) {
        range = [self rangeOfString:substring options:0 range:range];
        if (range.location != NSNotFound) {
            count++;
            range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
        }
    }
    
    return count;
}

// http://stackoverflow.com/questions/1524604/md5-algorithm-in-objective-c
- (NSString *)md5String
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
