//
//  NSString+Tools.h
//  FearlessLittle
//
//  Created on 6/3/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Tools)

/**
 Returns a new string that is trimmed of whitespace and newline characters.
 */
- (NSString *)cleanString;

/**
 Returns the number of occurences of a given substring.
 */
- (NSUInteger)numberOfOccurencesOfSubstring:(NSString *)substring;

/**
 Returns md5 based on current string.
 */
- (NSString *)md5String;

@end
