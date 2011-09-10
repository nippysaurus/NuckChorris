//
//  SettingsViewController.h
//  NuckChorris
//
//  Created by Michael Dawson on 13/07/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NuckChorrisAppDelegate.h"
#import "SHK.h"
#import "SHKTwitter.h"
#import "SHKFacebook.h"
#import "FactManager.h"

@interface SettingsViewController : UIViewController
{
    //
}

@property (nonatomic, retain) IBOutlet UIButton *deauthorizeButton;
@property (nonatomic, retain) IBOutlet UITextField *nameTextField;

- (IBAction)deauthorizeShareServices:(id)sender;
- (IBAction)contactSupport:(id)sender;
- (IBAction)resetHelpBubbles;

@end