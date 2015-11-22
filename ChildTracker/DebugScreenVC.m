//
//  DebugScreenVC.m
//  ChildTracker
//
//  Created by dev on 22/11/15.
//  Copyright © 2015 Lodossteam. All rights reserved.
//

#import "DebugScreenVC.h"
#import "StoreData.h"

@interface DebugScreenVC ()

- (IBAction)resetTokenBTPress:(id)sender;
- (IBAction)saveTokenBTPress:(id)sender;


@end

@implementation DebugScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)resetTokenBTPress:(id)sender
{
    [StoreData deleteSavedToken];
}

- (IBAction)saveTokenBTPress:(id)sender
{
    [StoreData saveToken:@"bcbc7869-efbf-4a6b-9fa4-eabcafda7f27"];
}
@end
