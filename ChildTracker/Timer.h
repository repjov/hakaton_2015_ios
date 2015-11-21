//
//  Timer.h
//  ChildTracker
//
//  Created by dev on 21/11/15.
//  Copyright © 2015 Lodossteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Consts.h"

@interface Timer : NSObject

@property (strong, atomic) NSTimer *timer;
@property (assign, atomic) int totalTimeElapsedInSeconds;

- (void)start;
- (void)stop;

@end
