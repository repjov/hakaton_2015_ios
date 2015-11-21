//
//  LandingScreen.m
//  ChildTracker
//
//  Created by dev on 21/11/15.
//  Copyright © 2015 Lodossteam. All rights reserved.
//

#import "RegisterScreen.h"

@interface RegisterScreen ()

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;

- (IBAction)registerButtonPress:(id)sender;

@end

@implementation RegisterScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerButtonPress:(id)sender
{
    //[self goCOdeINputScreen];
}

- (void)goCOdeINputScreen
{
    //[self.navigationController showViewController:<#(nonnull UIViewController *)#> sender:<#(nullable id)#>];
    [self performSegueWithIdentifier: @"segueCodeInput" sender: self];
}

@end
