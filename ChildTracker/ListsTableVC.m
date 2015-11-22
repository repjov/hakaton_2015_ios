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
#import "PreviewTableViewCell.h"

@interface ListsTableVC () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *playListsLoc;


@end

@implementation ListsTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getLists];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self cacheImages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)cacheImages
{
    for (NSDictionary *listDict in self.playListsLoc)
    {
        NSString *urlString = listDict[@"thumbnail"];
        CurrentUserSession *current = [CurrentUserSession sharedInstance];
        //UIImage *image = nil;
        if ([current isHaveImageForURL:urlString])
        {
            //image = [current imageForURL:urlString];
        }
        else
        {
            __weak __typeof(self)weakSelf = self;
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                UIImage *image2 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
                [current addImage:image2 forURL:urlString];
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    __strong __typeof(self)strongSelf = weakSelf;
                    [strongSelf.tableView reloadData];
                });
            });
        }
    }
}

- (void)playVideWithID:(NSString *)videYTID
{
    if (videYTID == nil) return;
}

- (void)getLists
{
    NSString *token = [[CurrentUserSession sharedInstance] token];
    if (token == nil) NSLog(@" ### !!! TOKEN NULL !!!");
    
    if (kWorkWithBackend)
    {
        __weak __typeof(self)weakSelf = self;
        [NetworkManager getListsForToken:token method:@"GET" success:^(NSData *data) {
            __strong __typeof(self)strongSelf = weakSelf;
            
            NSError *parseError = nil;
            NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            //NSLog(@" ### getListsForToken : <%@>", responseArray);
            
            [CurrentUserSession sharedInstance].playLists = responseArray;
            strongSelf.playListsLoc = responseArray;
            [strongSelf cacheImages];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf.tableView reloadData];
            });
            
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
    self.playListsLoc = [CurrentUserSession sharedInstance].playLists;
    return [self.playListsLoc count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"previewCell";
    PreviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[PreviewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *listDict = [self.playListsLoc objectAtIndex:indexPath.row];
    
    cell.name.text = listDict[@"name"];
    
    NSString *urlString = listDict[@"thumbnail"];
    CurrentUserSession *current = [CurrentUserSession sharedInstance];
    UIImage *image = nil;
    if ([current isHaveImageForURL:urlString])
    {
        image = [current imageForURL:urlString];
    }
    else
    {
        //image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
        //[current addImage:image forURL:urlString];
    }
    
    cell.image.image = image;
    cell.image.layer.cornerRadius = cell.image.frame.size.height / 16;
    
    //cell.videosArray = listDict[videosArray];
    //NSString *value = [self.SignalStimulateMatrix objectAtIndex:[indexPath row]];
    //[cell.textLabel setText:value];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //self.currentWord = [self.SignalStimulateMatrix objectAtIndex:[indexPath row]];
    
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];

    NSDictionary *listDict = [self.playListsLoc objectAtIndex:indexPath.row];
    [CurrentUserSession sharedInstance].playListDict = listDict;
    //[CurrentUserSession sharedInstance].videosArray = listDict[videosArray];
    
    [self performSegueWithIdentifier: @"segueVideosInListPreview" sender: self];
}

@end
