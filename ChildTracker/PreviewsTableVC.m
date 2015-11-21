//
//  PreviewsTableVC.m
//  ChildTracker
//
//  Created by dev on 21/11/15.
//  Copyright © 2015 Lodossteam. All rights reserved.
//

#import "PreviewsTableVC.h"
#import "YTPlayerView.h"
#import "CurrentUserSession.h"
#import "PreviewTableViewCell.h"
#import "NetworkManager.h"

@interface PreviewsTableVC () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet YTPlayerView *YTPlayerV;
@property (strong, nonatomic) IBOutlet UIButton *closePlayerButton;

@property (strong, nonatomic) NSDictionary *listDict;
@property (strong, nonatomic) NSArray *videosArray;

- (IBAction)closePlayerButtonPressed:(id)sender;

@end

@implementation PreviewsTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getVideos];
    self.YTPlayerV.backgroundColor = [UIColor clearColor];
    
    [self hideVideoControls];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(stopStatus:)
                                                 name:@"stopStatus"
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.videosArray = [[CurrentUserSession sharedInstance] videosArray];
    self.listDict = [[CurrentUserSession sharedInstance] playListDict];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)stopStatus:(NSNotification *)note
{
    //NSDictionary *theData = [note userInfo];
    [self closePlayerButtonPressed:nil];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = (UIViewController *)[sb instantiateViewControllerWithIdentifier:@"sleepScreenID"];
    [self.navigationController presentModalViewController:vc animated:YES];
}

- (void)playVideWithID:(NSString *)videYTID
{
    if (videYTID == nil) return;
    
    NSDictionary *playerVars = @{
                                 @"controls" : @"1",
                                 @"playsinline" : @"1",
                                 @"autohide" : @"1",
                                 @"showinfo" : @"0",
                                 @"autoplay" : @"1",
                                 @"fs" : @"1",
                                 @"rel" : @"0",
                                 @"loop" : @"0",
                                 @"enablejsapi" : @"1",
                                 @"modestbranding" : @"1",};
    [self.YTPlayerV loadWithVideoId:videYTID playerVars:playerVars];
    
    [self showVideoControls];
}

- (void)getVideos
{
    NSString *token = [[CurrentUserSession sharedInstance] token];
    if (token == nil) NSLog(@" ### !!! TORKEN NULL !!!");
    
    NSString *listID = self.listDict[@"id"];
    
    if (kWorkWithBackend)
    {
        __weak __typeof(self)weakSelf = self;
        
        [NetworkManager getVideosForToken:token listID:listID success:^(NSData *data)
        {
            __strong __typeof(self)strongSelf = weakSelf;
                
            NSError *parseError = nil;
            NSArray *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            [CurrentUserSession sharedInstance].videosArray = responseDictionary;
            [strongSelf.tableView reloadData];
            
        } error:^(NSString *localizedDescriptionText) {} cleanup:^{}];
    }
}

- (IBAction)closePlayerButtonPressed:(id)sender
{
    [self.YTPlayerV stopVideo];
    [self hideVideoControls];
}

- (void)hideVideoControls
{
    self.YTPlayerV.hidden = YES;
    self.closePlayerButton.hidden = YES;
}

- (void)showVideoControls
{
    self.YTPlayerV.hidden = NO;
    self.closePlayerButton.hidden = NO;
}

#pragma UITableView - delegate methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return [self.SignalStimulateMatrix count];
    self.videosArray = [[CurrentUserSession sharedInstance] videosArray];
    
    return [self.videosArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"previewCell";
    PreviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[PreviewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *videoDict = [self.videosArray objectAtIndex:indexPath.row];
    
    //NSString *value = [self.SignalStimulateMatrix objectAtIndex:[indexPath row]];
    //[cell.textLabel setText:value];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //self.currentWord = [self.SignalStimulateMatrix objectAtIndex:[indexPath row]];
    
    NSDictionary *videoDict = [self.videosArray objectAtIndex:indexPath.row];
    
    if (kWorkWithBackend)
    {
        NSString *videoID = videoDict[@"id"];
        if (videoID != nil)
        {
            [self playVideWithID:videoID];
        }
    }
    else
    {
        [self playVideWithID:@"M7lc1UVf-VE"];
    }
    
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

@end
