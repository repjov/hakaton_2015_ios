//
//  Timer.m
//  ChildTracker
//
//  Created by dev on 21/11/15.
//  Copyright © 2015 Lodossteam. All rights reserved.
//

#import "Timer.h"
#import "NetworkManager.h"
#import "CurrentUserSession.h"

@implementation Timer

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.isCheckStatusControl = NO;
    }
    return self;
}

- (void)start
{
    self.totalTimeElapsedInSeconds = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                  target:self
                                                selector:@selector(timerTick)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)stop
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)timerTick
{
    int seconds = (int) self.timer.timeInterval;
    self.totalTimeElapsedInSeconds = self.totalTimeElapsedInSeconds + seconds;
    //NSLog(@" ### time: %i", self.totalTimeElapsedInSeconds);
    
    if (self.isCheckStatusControl)
    {
        NSString *token = [[CurrentUserSession sharedInstance] token];
        
        [NetworkManager  getControlForToken:token method:@"GET" success:^(NSData *data) {
            
            NSError *parseError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            //NSLog(@" ### getControlForToken : <%@>", responseDictionary);
            
            NSNumber *status = responseDictionary[@"the_end"];
            if (status != nil)
            {
                if ([status isEqualToNumber:[NSNumber numberWithInt:1]])
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (!([CurrentUserSession sharedInstance].stopStatus))
                        {
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"stopStatus" object:self];
                            [CurrentUserSession sharedInstance].stopStatus = YES;
                        }
                    });
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"canPlayStatus" object:self];
                    });
                }
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"canPlayStatus" object:self];
                });
            }

            
        } error:^(NSString *localizedDescriptionText) {} cleanup:^{}];
    }
}

@end
