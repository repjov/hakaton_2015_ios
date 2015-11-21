//
//  PreviewsScreen.m
//  ChildTracker
//
//  Created by dev on 21/11/15.
//  Copyright © 2015 Lodossteam. All rights reserved.
//

#import "PreviewsScreen.h"
#import "YTPlayerView.h"

@interface PreviewsScreen () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet YTPlayerView *YTPlayerV;
@property (strong, nonatomic) IBOutlet UIButton *closePlayerButton;

- (IBAction)closePlayerButtonPressed:(id)sender;

@end

@implementation PreviewsScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.YTPlayerV.backgroundColor = [UIColor clearColor];
    
    [self hideVideoControls];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    [self playVideWithID:@"M7lc1UVf-VE"];
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

@end
