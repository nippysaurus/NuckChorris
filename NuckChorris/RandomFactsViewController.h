//
//  RandomFactsViewController.h
//  NuckChorris
//
//  Created by Michael Dawson on 26/06/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NuckChorrisAppDelegate.h"
//#import "RandomFactLabel.h"
#import "RandomFact.h"

@interface RandomFactsViewController : UIViewController
{
    //NSInteger currentFactId;
    //RandomFact *nextToPopulateWithFact;
    
    //BOOL alreadyDisplayedOnce;
}

@property (nonatomic, retain) IBOutlet RandomFact *randomFactViewFromNib;

//@property (nonatomic, retain) IBOutlet RandomFactLabel *fact1;
//@property (nonatomic, retain) IBOutlet RandomFactLabel *fact2;
//@property (nonatomic, retain) IBOutlet RandomFactLabel *fact3;
//@property (nonatomic, retain) IBOutlet RandomFactLabel *fact4;
//@property (nonatomic, retain) IBOutlet UIView *tapableRegionView;

@end