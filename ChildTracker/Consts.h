//
//  Consts.h
//  Instasound
//
//  Created by dev on 16/11/15.
//  Copyright © 2015 Lodossteam. All rights reserved.
//
// #import "Consts.h"
//

#import <Foundation/Foundation.h>
//#import "NSString+Extensions.h"

//typedef NS_ENUM (NSInteger, MessageTabIndex) {
//    TextMessageTabIndex = 0,
//    VidaoPhotosMessageTabIndex,
//    PhotoMessageTabIndex,
//    VideoMessageTabIndex,
//    AudioMessageTabIndex
//};

@interface Consts : NSObject

#pragma mark - Debug Flags

extern BOOL const kNetworkLogging;

#pragma mark - Server

extern NSString *const kServerURL;

#pragma mark - Server Endpoints

extern NSString *const kRegisterEnpoint;
extern NSString *const kAllListsEnpoint;
extern NSString *const kAllVideoInListEnpoint;
extern NSString *const kTrackingEnpoint;
extern NSString *const kControlEnpoint;

#pragma mark - Sockets

#pragma mark - Date Formatters

#pragma mark - Font Names

#pragma mark - Notifications

#pragma mark - RequestHeaders

#pragma mark - Cookies

#pragma mark - User Defaults

#pragma mark - Error Messages

#pragma mark - Dictionary keys

#pragma mark -  Core Data attibutes

#pragma mark - Storyboard Segues

#pragma mark - UI constants

#pragma mark - NSURLSession

extern NSString *const kSessionHTTPPostMethod;
extern NSString *const kSessionHTTPValue;
extern NSString *const kSessionHTTPHeaderField;

#pragma mark - Debug Error Outputting

extern NSString *const kAssertMessageFormat;

#pragma mark - SingleTone Alias

#define SINGLETON_DEF \
+ (instancetype)sharedInstance;

#define SINGLETON_IMP \
+ (instancetype)sharedInstance\
{\
static id instance;\
static dispatch_once_t pred;\
dispatch_once(&pred, ^{ instance = [[self alloc] init]; });\
return instance;\
}

#pragma mark - VC Lifecycle

#pragma mark - Init

#pragma mark - IBActions

#pragma mark - Actions

#pragma mark - Other

#pragma mark - Segues

@end
