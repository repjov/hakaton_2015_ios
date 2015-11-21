//
//  ListsTableVC.m
//  ChildTracker
//
//  Created by dev on 21/11/15.
//  Copyright © 2015 Lodossteam. All rights reserved.
//

#import "ListsTableVC.h"
#import "NetworkManager.h"
#import "CurrentUserSession.h"

@interface ListsTableVC () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ListsTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getLists];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)playVideWithID:(NSString *)videYTID
{
    if (videYTID == nil) return;
}

- (void)getLists
{
    NSString *token = [[CurrentUserSession sharedInstance] token];
    if (token == nil) NSLog(@" ### !!! TORKEN NULL !!!");
    
    if (kWorkWithBackend)
    {
        __weak __typeof(self)weakSelf = self;
        [NetworkManager getListsForToken:token success:^(NSData *data) {
            __strong __typeof(self)strongSelf = weakSelf;
            
            NSError *parseError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            [strongSelf saveLists:responseDictionary];
            
            [strongSelf.tableView reloadData];
            
        } error:^(NSString *localizedDescriptionText) {} cleanup:^{}];
    }
}

- (void)saveLists:(NSDictionary *)resonseDict
{
    NSArray *listsArray = resonseDict[@"playlists"];
    [CurrentUserSession sharedInstance].playLists = listsArray;
}


#pragma UITableView - delegate methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"previewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    //NSString *value = [self.SignalStimulateMatrix objectAtIndex:[indexPath row]];
    //[cell.textLabel setText:value];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //self.currentWord = [self.SignalStimulateMatrix objectAtIndex:[indexPath row]];
    
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    
}

@end
