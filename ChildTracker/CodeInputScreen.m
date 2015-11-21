//
//  CodeInputScreen.m
//  ChildTracker
//
//  Created by dev on 21/11/15.
//  Copyright © 2015 Lodossteam. All rights reserved.
//

#import "CodeInputScreen.h"
#import "CurrentUserSession.h"

@interface CodeInputScreen ()

@property (strong, nonatomic) IBOutlet UITextField *codeTextField;
@property (strong, nonatomic) IBOutlet UIButton *sendAuthCOdeButton;


- (IBAction)sendAuthCOdeButtonPress:(id)sender;

@end

@implementation CodeInputScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.codeTextField addTarget:self
                            action:@selector(textFieldDidChange:)
                  forControlEvents:UIControlEventEditingChanged];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([CurrentUserSession sharedInstance].email != nil)
    {
        self.userEmail.text = [CurrentUserSession sharedInstance].email;
    }
    
    self.sendAuthCOdeButton.enabled = NO;
    self.sendAuthCOdeButton.alpha = 0.5;
    self.codeTextField.text = @"";
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

- (void)goPreviewsScreen
{
    //[self.navigationController showViewController:<#(nonnull UIViewController *)#> sender:<#(nullable id)#>];
    [self performSegueWithIdentifier: @"segueLists" sender: self];
}

- (IBAction)sendAuthCOdeButtonPress:(id)sender
{
    [self goPreviewsScreen];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    NSString *trimmedString = ([textField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]]);
    if (trimmedString.length > 0)
    {
        self.sendAuthCOdeButton.enabled = YES;
        self.sendAuthCOdeButton.alpha = 1;
    }
    else
    {
        self.sendAuthCOdeButton.enabled = NO;
        self.sendAuthCOdeButton.alpha = 0.3;
    }
}

@end
