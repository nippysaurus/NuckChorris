//
//  SettingsViewController.m
//  NuckChorris
//
//  Created by Michael Dawson on 13/07/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import "SettingsViewController.h"


@implementation SettingsViewController

@synthesize deauthorizeButton = _deauthorizeButton;
@synthesize nameTextField = _nameTextField;

#pragma mark - Memory Management

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        // Custom initialization
    }
    
    return self;
}

- (void)dealloc
{
    self.deauthorizeButton = nil;
    
    [_nameTextField release];
    [super dealloc];
}

#pragma mark - View lifecycle

-(void)viewWillAppear:(BOOL)animated
{
    FactManager *factManager = [FactManager sharedInstance];
    
    self.nameTextField.text = factManager.substituteName;

    CGRect inset = CGRectMake(self.nameTextField.bounds.origin.x + 10, self.nameTextField.bounds.origin.y, self.nameTextField.bounds.size.width - 10, self.nameTextField.bounds.size.height);
    self.nameTextField.bounds = inset;
}

- (void)viewDidUnload
{
    self.deauthorizeButton = nil;

    [super viewDidUnload];
}

- (IBAction)deauthorizeShareServices:(id)sender
{
    [SHK logoutOfAll];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"Deauthorize Share Services"
                          message: @"You have been signed out of any sharing service that you have logged into in this application."
                          delegate: self
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil];
    
    [alert show];
    [alert release];
}

#pragma mark - Interaction

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NuckChorrisAppDelegate *app = (NuckChorrisAppDelegate*)[UIApplication sharedApplication].delegate;
    
    NSString *newName = self.nameTextField.text;
    
    FactManager *factManager = [FactManager sharedInstance];
    
    [factManager setSubstituteName:newName];

    app.randomViewNeedsUpdate = YES;
    app.listViewNeedsUpdate = YES;
    app.favorteViewNeedsUpdate = YES;
    
    [textField resignFirstResponder];
    
    return YES;
}

- (IBAction)contactSupport:(id)sender
{
    NSURL *googleURL = [NSURL URLWithString:@"http://nippysaurus.wufoo.com/forms/nuck-chorris-feedback-form/"];
    
    if(![[UIApplication sharedApplication] openURL:googleURL]){
        NSLog(@"Failed to open URL");
    }
}

- (IBAction)resetHelpBubbles
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"Help Bubbles Reset"
                          message: @"The help bubbles which appeared when you first used this application will appear again when you go to those views."
                          delegate: nil
                          cancelButtonTitle:@"Thank You"
                          otherButtonTitles:nil];
    
    [alert show];
    [alert release];

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"random_tab_first_time"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"favorites_tab_first_time"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end