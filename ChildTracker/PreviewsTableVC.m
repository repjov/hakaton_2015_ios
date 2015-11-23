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

@property (strong, nonatomic) UIRefreshControl *myPullRefr;

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
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self cacheImages];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    self.myPullRefr = refreshControl;
    
    [self changeBackButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self initTimer];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self startAutoplay];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(stopStatus:)
                                                 name:@"stopStatus"
                                               object:nil];
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

- (void)initTimer
{
    self.stopTimer = [[Timer alloc] init];
    self.stopTimer.isCheckStatusControl = YES;
    [self.stopTimer start];
}

- (void)refreshTable
{
    [self getVideos];
}

- (void)changeBackButton
{
    UIImage *image = [UIImage imageNamed:@"oval"];
    
    UIView *backButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [back setImage:image forState:UIControlStateNormal];
    
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backButtonView addSubview:back];
    UIBarButtonItem *backButton =  [[UIBarButtonItem alloc] initWithCustomView:backButtonView];
    
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cacheImages
{
    for (NSDictionary *videoDict in self.videosArray)
    {
        NSString *urlString = ((videoDict[@"thumbnails"])[@"high"])[@"url"];
        CurrentUserSession *current = [CurrentUserSession sharedInstance];

        if ([current isHaveImageForURL:urlString])
        {

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

- (void)stopStatus:(NSNotification *)note
{
    //NSDictionary *theData = [note userInfo];
    [self closePlayerButtonPressed:nil];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = (UIViewController *)[sb instantiateViewControllerWithIdentifier:@"sleepScreenID"];
    [self.navigationController presentViewController:vc animated:YES completion:^{}];
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
    if (token == nil) NSLog(@" ### !!! TOKEN NULL !!!");
    
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
            
            //NSArray *responseArrayFiltered = [self filterArray:responseArray];
            NSArray *responseArrayFiltered = responseArray;
            
            [CurrentUserSession sharedInstance].videosArray = responseArrayFiltered;
            strongSelf.videosArray = responseArrayFiltered;
            [strongSelf cacheImages];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf.tableView reloadData];
            });
            
        } error:^(NSString *localizedDescriptionText) {} cleanup:^{
            [self.myPullRefr endRefreshing];
        }];
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

- (void)back
{    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma UITableView - delegate methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    
    NSString *urlString = ((videoDict[@"thumbnails"])[@"high"])[@"url"];
    CurrentUserSession *current = [CurrentUserSession sharedInstance];
    UIImage *image = nil;
    if ([current isHaveImageForURL:urlString])
    {
        image = [current imageForURL:urlString];
    }
    else
    {
        
    }
    
    cell.image.image = image;
    cell.image.layer.cornerRadius = cell.image.frame.size.height / 16;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    if (token == nil) NSLog(@" ### !!! TOKEN NULL !!!");
    
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
