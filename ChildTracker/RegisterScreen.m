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
#import "NetworkManager.h"
#import "CurrentUserSession.h"

#import "Timer.h"

@interface RegisterScreen ()

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

//@property (strong, nonatomic) IBOutlet Timer *myTimer;

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
        NSString *token = [StoreData loadToken];
        [[CurrentUserSession sharedInstance] startSessionWithToken:token];
        [self goListsScreen];
    }
    
//    self.myTimer = [[Timer alloc] init];
//    [self.myTimer start];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self disableButton];
    
    [self.emailTextField becomeFirstResponder];
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
    UIActivityIndicatorView *indictaor = [self disableLoginControls];
    
    if (kWorkWithBackend)
    {
        __weak __typeof(self)weakSelf = self;
        [NetworkManager registerUser:userEmail success:^(NSData *data) {
            __strong __typeof(self)strongSelf = weakSelf;
            
            NSError *parseError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            NSString *token = responseDictionary[@"token"];
            if (token)
            {
                [StoreData saveToken:token];
                [[CurrentUserSession sharedInstance] startSessionWithToken:token];
                //[strongSelf getLists];
                [strongSelf goListsScreen];
            }
            else
            {
                NSLog(@" ### Error Token Parse");
            }
        } error:^(NSString *localizedDescriptionText) {
            NSLog(@" ### Error on Registration: <%@>", localizedDescriptionText);
        } cleanup:^{
            __strong __typeof(self)strongSelf = weakSelf;
            [strongSelf enableLoginControls:indictaor];
        }];
    }
    else
    {
        //[self goCOdeINputScreen];
        [self goListsScreen];
    }
}

//- (void)goCOdeINputScreen
//{
//    //[self.navigationController showViewController:<#(nonnull UIViewController *)#> sender:<#(nullable id)#>];
//    [self performSegueWithIdentifier: @"segueCodeInput" sender: self];
//}

- (void)disableButton
{
    self.registerButton.enabled = NO;
    self.registerButton.backgroundColor = [UIColor grayColor];
    self.registerButton.alpha = 0.3;
}

- (void)enableButton
{
    self.registerButton.enabled = YES;
    self.registerButton.backgroundColor = [UIColor redColor];
    self.registerButton.alpha = 1;
}

- (UIActivityIndicatorView *)disableLoginControls
{
    [self disableButton];
    
    CGRect defFrame = CGRectMake(0, 0, 50, 50);
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:defFrame];
    indicator.center = CGPointMake((self.registerButton.center.x / 2), self.registerButton.center.y);
    indicator.hidesWhenStopped = YES;
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.scrollView addSubview:indicator];
    [indicator startAnimating];
    
    return indicator;
}

- (void)enableLoginControls:(UIActivityIndicatorView *)indicator
{
    [self enableButton];
    
    [indicator stopAnimating];
    [indicator removeFromSuperview];
}

- (void)goListsScreen
{
    //[self.navigationController showViewController:<#(nonnull UIViewController *)#> sender:<#(nullable id)#>];
    [self performSegueWithIdentifier: @"appAlreadyAuthorized" sender: self];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    NSString *trimmedString = ([textField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]]);
    if (trimmedString.length > 0)
    {
        [self enableButton];
    }
    else
    {
        [self disableButton];
    }
}

@end
