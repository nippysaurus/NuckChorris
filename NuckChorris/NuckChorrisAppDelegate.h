//
//  NuckChorrisAppDelegate.h
//  NuckChorris
//
//  Created by Michael Dawson on 26/06/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "RateThisAppDialog.h"
#import "SHK.h"

@class NuckChorrisViewController;

@interface NuckChorrisAppDelegate : NSObject <UIApplicationDelegate>
{
    //
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property (nonatomic) BOOL randomViewNeedsUpdate;
@property (nonatomic) BOOL listViewNeedsUpdate;
@property (nonatomic) BOOL favorteViewNeedsUpdate;

@end