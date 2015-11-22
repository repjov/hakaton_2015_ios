//
//  SleepVC.m
//  ChildTracker
//
//  Created by dev on 22/11/15.
//  Copyright © 2015 Lodossteam. All rights reserved.
//

#import "SleepVC.h"

@interface SleepVC ()

@end

@implementation SleepVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(canPlayStatus:)
                                                 name:@"canPlayStatus"
                                               object:nil];
}

- (void)canPlayStatus:(NSNotification *)note
{
    //NSDictionary *theData = [note userInfo];
    
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
