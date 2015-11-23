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
BOOL const kWorkWithBackend = YES;

#pragma mark - Server

NSString *const kServerURL = @"http://api.childtracker.co";
#pragma mark - Server Endpoints

NSString *const kRegisterEnpoint = @"/new";
NSString *const kActivationEnpoint = @"/activation";
NSString *const kAllListsEnpoint = @"/%@/lists";
NSString *const kAllVideoInListEnpoint = @"/%@/lists/%@";
NSString *const kTrackingEnpoint = @"/%@/play/tracking";
NSString *const kControlEnpoint = @"/%@/play/control";

//NSString *const kNewListEnpoint = @"/%@/lists";
//NSString *const kNewListEnpoint = @"/%@/lists";

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

NSString *const kSessionHTTPPostMethod = @"POST";
NSString *const kSessionHTTPValue = @"application/json";
NSString *const kSessionHTTPHeaderField = @"Content-Type";

#pragma mark - Debug Error Outputting

NSString *const kAssertMessageFormat = @" ### Error! NSAssert <%s>. Parameter '%@' is nil/empty";

@end