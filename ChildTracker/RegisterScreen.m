//
//  LandingScreen.m
//  ChildTracker
//
//  Created by dev on 21/11/15.
//  Copyright © 2015 Lodossteam. All rights reserved.
//

#import "RegisterScreen.h"
#import "CurrentUserSession.h"
#import "NSString+Extensions.h"
#import "StoreData.h"

@interface RegisterScreen ()

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;

- (IBAction)registerButtonPress:(id)sender;

@end

@implementation RegisterScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.emailTextField addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
    
    if ([StoreData isHaveTokenAlready])
    {
        [self goPreviewScreen];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.registerButton.enabled = NO;
    self.registerButton.alpha = 0.5;
    self.emailTextField.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerButtonPress:(id)sender
{
    NSString *userEmail = self.emailTextField.text;
    if ([NSString isNilOrEmpty:userEmail]) return;
    
    [CurrentUserSession sharedInstance].email = userEmail;
    
    [self goCOdeINputScreen];
}

- (void)goCOdeINputScreen
{
    //[self.navigationController showViewController:<#(nonnull UIViewController *)#> sender:<#(nullable id)#>];
    [self performSegueWithIdentifier: @"segueCodeInput" sender: self];
}

- (void)goPreviewScreen
{
    //[self.navigationController showViewController:<#(nonnull UIViewController *)#> sender:<#(nullable id)#>];
    [self performSegueWithIdentifier: @"appAlreadyAuthorized" sender: self];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    NSString *trimmedString = ([textField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]]);
    if (trimmedString.length > 0)
    {
        self.registerButton.enabled = YES;
        self.registerButton.alpha = 1;
    }
    else
    {
        self.registerButton.enabled = NO;
        self.registerButton.alpha = 0.3;
    }
}

@end
