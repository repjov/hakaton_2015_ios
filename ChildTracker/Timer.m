//
//  Timer.m
//  ChildTracker
//
//  Created by dev on 21/11/15.
//  Copyright © 2015 Lodossteam. All rights reserved.
//

#import "Timer.h"

@implementation Timer

- (instancetype)init
{
    self = [super init];
    if (self)
    {

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
}

@end
