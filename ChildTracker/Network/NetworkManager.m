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
             success:(void (^)(NSData *data))successBlock
               error:(void (^)(NSString *localizedDescriptionText))errorBlock
             cleanup:(void (^)())cleanupBlock

{
    NSAssert((email != nil), kAssertMessageFormat, __PRETTY_FUNCTION__, @"email");
    
    if (email == nil) return;
    
    NSString *body;
    body = [NSString stringWithFormat: @"{\n \"email\": \"%@\"}", email];
    
    [NetworkRequestSender sendToEndpoint:kRegisterEnpoint body:body success:successBlock error:errorBlock cleanup:cleanupBlock];
}

+ (void)getListsForToken:(NSString *)token
         success:(void (^)(NSData *data))successBlock
           error:(void (^)(NSString *localizedDescriptionText))errorBlock
         cleanup:(void (^)())cleanupBlock

{
    NSAssert((token != nil), kAssertMessageFormat, __PRETTY_FUNCTION__, @"email");
    
    if (token == nil) return;
    
    NSString *body;
    body = [NSString stringWithFormat: @"{}"];
    
    NSString *endpoint = [NSString stringWithFormat:@"/%@/lists", token];
    
    [NetworkRequestSender sendToEndpoint:endpoint body:body success:successBlock error:errorBlock cleanup:cleanupBlock];
}

+ (void)getVideosForToken:(NSString *)token
                  listID:(NSString *)listID
                 success:(void (^)(NSData *data))successBlock
                   error:(void (^)(NSString *localizedDescriptionText))errorBlock
                 cleanup:(void (^)())cleanupBlock

{
    NSAssert((listID != nil), kAssertMessageFormat, __PRETTY_FUNCTION__, @"email");
    
    if (listID == nil) return;
    
    NSString *body;
    body = [NSString stringWithFormat: @"{}"];
    
    NSString *endpoint = [NSString stringWithFormat:@"/%@/lists/%@", token, listID];
    
    [NetworkRequestSender sendToEndpoint:endpoint body:body success:successBlock error:errorBlock cleanup:cleanupBlock];
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
