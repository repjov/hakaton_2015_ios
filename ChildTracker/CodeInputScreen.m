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
    
    self.sendAuthCOdeButton.layer.cornerRadius = self.sendAuthCOdeButton.frame.size.height / 4;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([CurrentUserSession sharedInstance].email != nil)
    {
        self.userEmail.text = [CurrentUserSession sharedInstance].email;
    }
    
    [self disableButton];
    self.codeTextField.text = @"";
    
    [self.codeTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)disableButton
{
    self.sendAuthCOdeButton.enabled = NO;
    self.sendAuthCOdeButton.backgroundColor = [UIColor grayColor];
    self.sendAuthCOdeButton.alpha = 0.3;
}

- (void)enableButton
{
    self.sendAuthCOdeButton.enabled = YES;
    self.sendAuthCOdeButton.backgroundColor = [UIColor redColor];
    self.sendAuthCOdeButton.alpha = 1;
}

- (void)goListsScreen
{
    [self performSegueWithIdentifier: @"segueLists" sender: self];
}

- (IBAction)sendAuthCOdeButtonPress:(id)sender
{
    [self goListsScreen];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    NSString *trimmedString = ([textField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]]);
    if (trimmedString.length > 0)
    {
        [self disableButton];
    }
    else
    {
        [self enableButton];
    }
}

@end
