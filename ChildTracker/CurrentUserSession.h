//
//  CurrentUserSession.h
//  Instasound
//
//  Created by dev on 17/11/15.
//  Copyright © 2015 Lodossteam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Consts.h"

@interface CurrentUserSession : NSObject

SINGLETON_DEF

- (void)startSessionWithToken:(NSString *)token;
- (void)resetSession;

- (BOOL)isHaveImageForURL:(NSString *)url;
- (UIImage *)imageForURL:(NSString *)url;
- (void)addImage:(UIImage *)image forURL:(NSString *)url;

@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *email;

@property (strong, nonatomic) NSArray *playLists;
@property (strong, nonatomic) NSDictionary *playListsImages;
@property (strong, nonatomic) NSArray *videosArray;
@property (strong, nonatomic) NSDictionary *videosArrayImages;

@property (strong, nonatomic) NSDictionary *playListDict;
@property (strong, nonatomic) NSDictionary *videoDict;

@property (strong, nonatomic) NSMutableDictionary *imageCache;

@property (assign, nonatomic) BOOL stopStatus;

@end
