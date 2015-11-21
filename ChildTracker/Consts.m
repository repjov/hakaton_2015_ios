//
//  Consts.m
//  Instasound
//
//  Created by dev on 16/11/15.
//  Copyright © 2015 Lodossteam. All rights reserved.
//
// #import "Consts.h"
//

#import "Consts.h"

@implementation Consts

#pragma mark - Debug Flags

BOOL const kNetworkLogging = YES;
//BOOL const kSocketLogging = YES;
//BOOL const kSocketDetailedLogging = YES;
//BOOL const kUserDebbugData = YES;

#pragma mark - Server

NSString *const kServerURL = @"http://api.instasound.com";
//NSString *const kServerHost = @"http://dev.instasound.com";

#pragma mark - Server Endpoints

NSString *const kSignUpEnpoint = @"/api/signup"; // http://dev.instasound.com/api/signup
NSString *const kSignInEnpoint = @"/api/signin"; // http://dev.instasound.com/api/signin
NSString *const kSignAuthFacebookEnpoint = @"/api/auth/facebookclient"; // http://dev.instasound.com/api/auth/facebookclient
NSString *const kLogOutInEnpoint = @"/api/logout"; // http://dev.instasound.com/api/logout?accessToken="DxuvhGmEfoxC8mBUEYUbTafm"

NSString *const kFeedEnpoint = @"/api/feeds"; // http://dev.instasound.com/api/feeds

NSString *const kFollowsEnpoint = @"/api/follows?"; // http://dev.instasound.com/api/follows?accessToken="DxuvhGmEfoxC8mBUEYUbTafm"
NSString *const kRequestFollowEnpoint = @"/api/follows?"; // http://dev.instasound.com/api/follows/request/id?accessToken="DxuvhGmEfoxC8mBUEYUbTafm"

NSString *const kUserByIDEnpoint = @"/api/users/id"; // http://dev.instasound.com/api/users/id?accessToken="DxuvhGmEfoxC8mBUEYUbTafm"

#pragma mark - Server Endpoints Params

NSString *const kAccessTokenEnpointParam = @"?accessToken=\"%@\"";

#pragma mark - Sockets

//NSString *const kSignUpRequestBodyFormat = @"{\n \"first_name\": \"%@\",\n  \"last_name\": \"%@\",\n  \"full_name\": \"%@\",\n  \"email\": \"%@\",\n  \"password\": \"%@\",\n  \"birth\": \"%@\",\n  \"gender\": \"%@\"}";

//NSString *const kSocketCallHistoryRequest = @"{\"jsonrpc\": \"2.0\", \"method\": \"getCallHistory\", \"params\": [], \"id\": %@}";
//NSString *const kSocketGetConversationsRequest = @"{\"jsonrpc\": \"2.0\", \"method\": \"getConversations\", \"params\": [], \"id\": %@}";
//NSString *const kSocketGetContactsConversationsRequest = @"{\"jsonrpc\": \"2.0\", \"method\": \"getConversations\", \"params\": {\"type\" : \"contacts\"}, \"id\": %@}";
//NSString *const kSocketGetNonContactsConversationsRequest = @"{\"jsonrpc\": \"2.0\", \"method\": \"getConversations\", \"params\": {\"type\" : \"other\"}, \"id\": %@}";
//NSString *const kSocketAcceptContactRequest = @"{\"jsonrpc\": \"2.0\", \"method\": \"approveContact\", \"params\": %@, \"id\": %@}";

#pragma mark - Date Formatters

//NSString *const kJSONDateFormat = @"yyyy-MM-dd'T'HH:mm:ssz";
//NSString *const kJSONDateWithMSFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSz";

#pragma mark - Font Names

//NSString *const kOpenSansRegular = @"OpenSans";
//NSString *const kOpenSansLight = @"OpenSans-Light";
//NSString *const kOpenSansLightItalic = @"OpenSansLight-Italic";

#pragma mark - Notifications

//NSString *const kPresenceUpdated = @"PresenceUpdated";
//NSString *const kUpdatedContactUserInfoKey = @"UpdatedContactUserInfoKey";

#pragma mark - RequestHeaders

//NSString *const kAllowCredentialsHeader = @"access-control-allow-credentials";
//NSString *const kContentTypeHeader = @"content-type";
//NSString *const kApplicationJsonHeaderValue = @"application/json";
//NSString *const kTrueHeaderValue = @"true";

#pragma mark - Cookies

//NSString *const kCookie = @"Cookie";
//NSString *const kCookieHeader = @"Set-Cookie";
//NSString *const kSessionIDParameter = @"session";
//NSString *const kSessionExpiresParameter = @"Expires";
//NSString *const kDomainParameter = @"Domain";

#pragma mark - User Defaults

//NSString *const kUserDefaultsCookieKey = @"UserDefaultsCookieKey";
//NSString *const kUserDefaultsLoginIDToVerify = @"UserDefaultsLoginIDToVerify";

#pragma mark - Error Messages

//NSString *const kErrorInvalidCredentials = @"Invalid Credentials";
//NSString *const kErrorUsernameTaken = @"Username Taken";
//NSString *const kErrorEmailTaken = @"Email Already Registered With ID";
//NSString *const kErrorEmailUsernameTaken = @"Email and Username Taken";
//NSString *const kErrorInvalidEmail = @"Invalid Email";
//NSString *const kErrorInvalidUsername = @"Invalid Username";
//NSString *const kErrorExpectedDataNotPresent = @"Expected data not present";
//NSString *const kErrorInvalidID = @"Invalid ID";
//NSString *const kErrorExpectedIDOrEmail = @"Expected ID or Email";

#pragma mark - Dictionary keys

////Server response
//NSString *const kResponseStatus = @"status";
//NSString *const kResponseError = @"error";
//NSString *const kResponseErrorMessage = @"message";

#pragma mark -  Core Data attibutes

////User
//NSString *const kCDUserEmail = @"email";
//NSString *const kCDUserSessionID = @"sessionID";

#pragma mark - Storyboard Segues

//NSString *const kLibraryMessageSegue = @"LibraryMessageSegue";
//NSString *const kSettingsSegue = @"SettingsMessageSegue";

#pragma mark - UI constants

//NSInteger const kContactDetailsMenuWidth = 154;
//NSInteger const kContactDetailsMenuHeight = 143;

#pragma mark - NSURLSession

NSString *const kSessionHTTPPostMethod = @"POST";
NSString *const kSessionHTTPValue = @"application/json";
NSString *const kSessionHTTPHeaderField = @"Content-Type";

#pragma mark - Debug Error Outputting

NSString *const kAssertMessageFormat = @" ### Error! NSAssert <%s>. Parameter '%@' is nil/empty";

@end