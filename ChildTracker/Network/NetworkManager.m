//
//  NetworkManager.m
//  Instasound
//
//  Created by dev on 17/11/15.
//  Copyright © 2015 Lodossteam. All rights reserved.
//

#import "NetworkManager.h"
#import "NetworkRequestSender.h"
#import "Consts.h"

@implementation NetworkManager

+ (void)registerUser:(NSString *)email
              method:(NSString *)method
             success:(void (^)(NSData *data))successBlock
               error:(void (^)(NSString *localizedDescriptionText))errorBlock
             cleanup:(void (^)())cleanupBlock

{
    NSAssert((email != nil), kAssertMessageFormat, __PRETTY_FUNCTION__, @"email");
    
    if (email == nil) return;
    
    NSString *body;
    body = [NSString stringWithFormat: @"{\"email\": \"%@\"}", email];
    
    [NetworkRequestSender sendToEndpoint:kRegisterEnpoint body:body method:method success:successBlock error:errorBlock cleanup:cleanupBlock];
}

+ (void)getListsForToken:(NSString *)token
              method:(NSString *)method
         success:(void (^)(NSData *data))successBlock
           error:(void (^)(NSString *localizedDescriptionText))errorBlock
         cleanup:(void (^)())cleanupBlock

{
    NSAssert((token != nil), kAssertMessageFormat, __PRETTY_FUNCTION__, @"email");
    
    if (token == nil) return;
    
    NSString *body = nil;
    
    //:@"POST"
    //body = [NSString stringWithFormat: @"[{\"id\":1448149362122,\"name\":\"Новая подборка\",\"active\":true},{\"id\":1448152392672,\"name\":\"Новая подборка\",\"active\":true},{\"id\":1448152461525,\"name\":\"Новая подборка\",\"active\":true},{\"id\":1448152536197,\"name\":\"Новая подборка\",\"active\":true},{\"id\":1448152576352,\"name\":\"Новая подборка\",\"active\":true},{\"id\":1448152623228,\"name\":\"Новая подборка\",\"active\":true}]"];
    
    //@"POST"
    //body = [NSString stringWithFormat: @"[{\"id\":1448149362122,\"name\":\"Детская Подборка #1\",\"active\":true,\"thumbnail\":\"https://i.ytimg.com/vi/6p26d5lVuiw/hqdefault.jpg\"},{\"id\":1448152392672,\"name\":\"Детская Подборка #2\",\"active\":true,\"thumbnail\":\"https://i.ytimg.com/vi/grrn9NU3KiA/hqdefault.jpg\"},{\"id\":1448152461525,\"name\":\"Детская Подборка #3\",\"active\":true,\"thumbnail\":\"https://i.ytimg.com/vi/T_9m73boXHg/hqdefault.jpg\"},{\"id\":1448152536197,\"name\":\"Детская Подборка #4\",\"active\":true,\"thumbnail\":\"https://i.ytimg.com/vi/onTmUaeURs0/hqdefault.jpg\"},{\"id\":1448152576352,\"name\":\"Детская Подборка #5\",\"active\":true,\"thumbnail\":\"https://i.ytimg.com/vi/zJKuknisBZg/hqdefault.jpg\"},{\"id\":1448152623228,\"name\":\"Детская Подборка #6\",\"active\":true,\"thumbnail\":\"https://i.ytimg.com/vi/AMtbjdHWqnk/hqdefault.jpg\"}]"];
    
    NSString *endpoint = [NSString stringWithFormat:@"/%@/lists", token];
    
    [NetworkRequestSender sendToEndpoint:endpoint body:body method:method success:successBlock error:errorBlock cleanup:cleanupBlock];
}

+ (void)getVideosForToken:(NSString *)token
                  listID:(NSString *)listID
              method:(NSString *)method
                 success:(void (^)(NSData *data))successBlock
                   error:(void (^)(NSString *localizedDescriptionText))errorBlock
                 cleanup:(void (^)())cleanupBlock

{
    NSAssert((listID != nil), kAssertMessageFormat, __PRETTY_FUNCTION__, @"listID");
    
    if (listID == nil) return;
    
    NSString *body = nil;
    //body = [NSString stringWithFormat: @"{}"];
    
    NSString *endpoint = [NSString stringWithFormat:@"/%@/lists/%@", token, listID];
    
    [NetworkRequestSender sendToEndpoint:endpoint body:body method:method success:successBlock error:errorBlock cleanup:cleanupBlock];
}

+ (void)getControlForToken:(NSString *)token
              method:(NSString *)method
                  success:(void (^)(NSData *data))successBlock
                    error:(void (^)(NSString *localizedDescriptionText))errorBlock
                  cleanup:(void (^)())cleanupBlock

{
    NSAssert((token != nil), kAssertMessageFormat, __PRETTY_FUNCTION__, @"email");
    
    if (token == nil) return;
    
    NSString *body = nil;
    //body = [NSString stringWithFormat: @"{}"];
    
    NSString *endpoint = [NSString stringWithFormat:@"/%@/play/control", token];
    
    [NetworkRequestSender sendToEndpoint:endpoint body:body method:method success:successBlock error:errorBlock cleanup:cleanupBlock];
}

+ (void)trackingWithToken:(NSString *)token
                    method:(NSString *)method
                    videoDict:(NSDictionary *)videoDict
                    playTimeIncrement:(NSUInteger *)playTimeIncrement
                   success:(void (^)(NSData *data))successBlock
                     error:(void (^)(NSString *localizedDescriptionText))errorBlock
                   cleanup:(void (^)())cleanupBlock

{
    NSAssert((token != nil), kAssertMessageFormat, __PRETTY_FUNCTION__, @"token");
    NSAssert((videoDict != nil), kAssertMessageFormat, __PRETTY_FUNCTION__, @"videoDict");
    
    if (token == nil) return;
    if (videoDict == nil) return;
    
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:videoDict
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    NSString *jsonString = nil;
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
        return;
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSString *body = nil;
    body = [NSString stringWithFormat: @"{\n \"now_watching\": %@, \"time\": \"%lu\"}", jsonString, (unsigned long)playTimeIncrement];
    
    NSString *endpoint = [NSString stringWithFormat:@"/%@/play/tracking", token];
    
    //{now_watching: utube_obj_1, time: 10}
    
    [NetworkRequestSender sendToEndpoint:endpoint body:body method:method success:successBlock error:errorBlock cleanup:cleanupBlock];
}


//+ (void)sendCode:(NSString *)code
//             success:(void (^)(NSString *accessToken))successBlock
//               error:(void (^)(NSString *localizedDescriptionText))errorBlock
//             cleanup:(void (^)())cleanupBlock
//
//{
//    NSAssert((code != nil), kAssertMessageFormat, __PRETTY_FUNCTION__, @"email");
//
//    if (code == nil) return;
//
//    NSString *body;
//    body = [NSString stringWithFormat: @"{\n \"code\": \"%@\"}", code];
//
//    [NetworkRequestSender sendToEndpoint:kActivationEnpoint body:body success:^(NSDictionary *resonseDict) {
//        NSString *token = resonseDict[@"token"];
//        if (token != nil)
//        {
//            successBlock(token);
//        }
//        else
//        {
//            errorBlock(@"Session token not found in aswer");
//        }
//    } error:errorBlock cleanup:cleanupBlock];
//}

//POST /new (email)->(token) - типа регистрации, возвращает перманентный токен с которым дальше все запросы
//
//GET /$token/lists - возвращает список списков воспроизведения
//
//GET /$token/lists/$list_id - возвращает список роликов в списке воспроизведения
//
//POST /$token/play/tracking - периодически, сюда посылаете время которое играет ролик, а я все суммирую. ну типа (10, 10, 13, 20) в секундах. я все суммирую, показываю родителям и в зависимости от настроек либо посылаю вам по сокетам  "горшочек не вари" и вы блокируете воспроизведение либо делаю то же самое по нажатию кнопки в веб-интерфейсе
//---
//POST /$token/play/control - сюда из веб интерфейса приходят команды типа STOP, MUTE
//
//POST /$token/lists (name)->(list_id) - создает новый список воспроизведения
//
//POST /$token/lists/$list_id - сохраняет список роликов в список воспроизведения

@end
