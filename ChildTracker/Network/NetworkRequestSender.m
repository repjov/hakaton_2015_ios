//
//  NetworkRequestSender.m
//  Instasound
//
//  Created by dev on 16/11/15.
//  Copyright © 2015 Lodossteam. All rights reserved.
//

#import "NetworkRequestSender.h"
#import "Consts.h"
#import "NSString+Extensions.h"
#import "CurrentUserSession.h"

@implementation NetworkRequestSender

+ (void)sendToEndpoint:(NSString *)endpoint
                  body:(NSString *)body
                method:(NSString *)method
               success:(void (^)(NSData *data))successBlock
                 error:(void (^)(NSString *localizedDescriptionText))errorBlock
               cleanup:(void (^)())cleanupBlock
{
    NSAssert((![NSString isNilOrEmpty:endpoint]), kAssertMessageFormat, __PRETTY_FUNCTION__, @"endpoint");
    //NSAssert((![NSString isNilOrEmpty:body]), kAssertMessageFormat, __PRETTY_FUNCTION__, @"body");
    
    if ([NSString isNilOrEmpty:endpoint]) return;
    //if ([NSString isNilOrEmpty:body]) return;
    
    NSString *fullURLAsString = [NSString stringWithFormat:@"%@%@", kServerURL, endpoint];
    NSMutableURLRequest *request = [NetworkRequestSender mutableURLRequestWithURL:fullURLAsString body:body];
    request.HTTPMethod = method;

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task;
    task = [session dataTaskWithRequest:request
                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          [NetworkRequestSender handleRequestAnswerWith:data
                                                                               response:response
                                                                                  error:error
                                                                                success:successBlock
                                                                                  error:errorBlock
                                                                                cleanup:cleanupBlock];
                                      }];
    [task resume];
}

+ (void)handleRequestAnswerWith:(NSData *)data
                       response:(NSURLResponse *)response
                          error:(NSError *)error
                        success:(void (^)(NSData *data))successBlock
                          error:(void (^)(NSString *localizedDescriptionText))errorBlock
                        cleanup:(void (^)())cleanupBlock
{
    if (!error)
    {
        if (kNetworkLogging) NSLog(@"URL: %@", response.URL);
        if ([response isKindOfClass:[NSHTTPURLResponse class]])
        {
            if (kNetworkLogging) NSLog(@"Response HTTP Status code: %ld\n", (long)[(NSHTTPURLResponse *)response statusCode]);
            //if (kNetworkLogging) NSLog(@"Response HTTP Headers:\n%@\n", [(NSHTTPURLResponse *)response allHeaderFields]);
            NSString *responseData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            if (kNetworkLogging) NSLog(@"Response Body:\n%@\n", responseData);
            
            NSInteger HTTPstatusCode = [(NSHTTPURLResponse *)response statusCode];
            
            NSError *parseError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            NSArray *responseA = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            //NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            //if (kNetworkLogging) NSLog(@"%@", responseDictionary);
            
            BOOL isSuccessResponseCodeIs = (HTTPstatusCode == 200);
            if (isSuccessResponseCodeIs)
            {
                if (successBlock) successBlock(data);
//                if (!parseError)
//                {
//                    if (successBlock) successBlock(responseDictionary);
//                }
//                else
//                {
//                    // Got success asnwer from server, but error occured while response parse
//                    if (errorBlock) errorBlock(parseError.localizedDescription);
//                }
            }
            else
            {
                if (errorBlock) errorBlock(responseData);
                
//                if (!parseError)
//                {
//                    // Got unsuccess asnwer from server
//                    NSDictionary *errosDict = [responseDictionary[@"errors"] firstObject];
//                    if (errosDict != nil)
//                    {
//                        if (errorBlock) errorBlock(errosDict[@"message"]);
//                    }
//                    else
//                    {
//                        NSString *errorString = responseDictionary[@"message"];
//                        if (errorString)
//                        {
//                            if (errorBlock) errorBlock(errorString);
//                        }
//                        else
//                        {
//                            // Got unsuccess asnwer from server, but can't parse it
//                            if (errorBlock) errorBlock(@"Error response from server");
//                        }
//                    }
//                }
            }
        }
    }
    else
    {
        // NSURLSessionDataTask Request Error
        if (kNetworkLogging) NSLog(@"error localizedDescription : %@", error.localizedDescription);
        if (kNetworkLogging) NSLog(@"error : %@", error);
        
        if (errorBlock) errorBlock(error.localizedDescription);
    }
    
    if (cleanupBlock) cleanupBlock();
}

+ (NSMutableURLRequest *)mutableURLRequestWithURL:(NSString *)URLString body:(NSString *)body
{
    NSMutableURLRequest *request = [NetworkRequestSender defaultMutableURLRequest];
    NSURL *URL = [NSURL URLWithString:URLString];
    [request setURL:URL];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    return request;
}

+ (NSMutableURLRequest *)defaultMutableURLRequest
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:kSessionHTTPPostMethod];
    [request setValue:kSessionHTTPValue forHTTPHeaderField:kSessionHTTPHeaderField];
    return request;
}

@end
