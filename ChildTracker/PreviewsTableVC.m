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
#import "Timer.h"

@interface PreviewsTableVC () <UITableViewDataSource, UITableViewDelegate, YTPlayerViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet YTPlayerView *YTPlayerV;
@property (strong, nonatomic) IBOutlet UIButton *closePlayerButton;

@property (strong, nonatomic) NSDictionary *listDict;
@property (strong, nonatomic) NSArray *videosArray;

@property (strong, nonatomic) NSDictionary *currentVideo;

@property (strong, nonatomic) Timer *stopTimer;

- (IBAction)closePlayerButtonPressed:(id)sender;

@end

@implementation PreviewsTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.YTPlayerV.delegate = self;
    self.videosArray = [[CurrentUserSession sharedInstance] videosArray];
    self.listDict = [[CurrentUserSession sharedInstance] playListDict];
    
    [self getVideos];
    self.YTPlayerV.backgroundColor = [UIColor clearColor];
    
    [self hideVideoControls];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    

    self.stopTimer = [[Timer alloc] init];
    self.stopTimer.isCheckStatusControl = YES;
    [self.stopTimer start];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(stopStatus:)
                                                 name:@"stopStatus"
                                               object:nil];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self startAutoplay];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealloc
{
    [self.stopTimer stop];
    self.stopTimer = nil;
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

- (void)startAutoplay
{
    NSDictionary * firstVideoDic = [self.videosArray firstObject];
    NSString *firstVidID = firstVideoDic[@"id"];
    
    self.currentVideo = firstVideoDic;
    
    [self playVideWithID:firstVidID];
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
        
        [NetworkManager getVideosForToken:token listID:listID method:@"GET" success:^(NSData *data)
        {
            __strong __typeof(self)strongSelf = weakSelf;
                
            NSError *parseError = nil;
            NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            //NSLog(@" ### getVideosForToken : <%@>", responseArray);
            
            [CurrentUserSession sharedInstance].videosArray = responseArray;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf.tableView reloadData];
            });
            
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
    
    cell.name.text = videoDict[@"title"];
    
    NSString *imageURL = ((videoDict[@"thumbnails"])[@"high"])[@"url"];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
    cell.image.image = image;
    
    cell.image.layer.cornerRadius = cell.image.frame.size.height / 16;
    
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
            self.currentVideo = videoDict;
            [self playVideWithID:videoID];
        }
    }
    else
    {
        [self playVideWithID:@"M7lc1UVf-VE"];
    }
    
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

- (void)sendVideoTrackingToBackend:(NSDictionary *)videoDict;
{
    NSString *token = [[CurrentUserSession sharedInstance] token];
    if (token == nil) NSLog(@" ### !!! TORKEN NULL !!!");
    
    [NetworkManager trackingWithToken:token method:@"POST" videoDict:videoDict playTimeIncrement:0 success:^(NSData *data) {} error:^(NSString *localizedDescriptionText) {} cleanup:^{}];
}

- (void)playerViewDidBecomeReady:(YTPlayerView *)playerView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Playback started" object:self];
    [self.YTPlayerV playVideo];
}

- (void)playerView:(YTPlayerView *)playerView didPlayTime:(float)playTime
{
    //NSLog(@"Video: <%@>, playTime: %f", self.currentVideo[@"id"], playTime);
}

- (void)playerView:(YTPlayerView *)playerView didChangeToState:(YTPlayerState)state
{
    if (state == kYTPlayerStatePlaying)
    {
        [self sendVideoTrackingToBackend:self.currentVideo];
        NSLog(@" @@@ 1 kYTPlayerStatePlaying");
    }
    
    if (state == kYTPlayerStatePaused)
    {
        [self sendVideoTrackingToBackend:@{}];
        NSLog(@" @@@ 2 kYTPlayerStatePaused");
    }
    
    if (state == kYTPlayerStateEnded)
    {
        [self sendVideoTrackingToBackend:@{}];
        NSLog(@" @@@ 3 kYTPlayerStateEnded");
    }
}

@end
