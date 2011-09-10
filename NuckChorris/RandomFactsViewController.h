//
//  RandomFactsViewController.h
//  NuckChorris
//
//  Created by Michael Dawson on 26/06/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NuckChorrisAppDelegate.h"
#import "RandomFact.h"
#import "FactManager.h"

@interface RandomFactsViewController : UIViewController
{
    //
}

@property (nonatomic, retain) IBOutlet RandomFact *randomFactViewFromNib;

@end