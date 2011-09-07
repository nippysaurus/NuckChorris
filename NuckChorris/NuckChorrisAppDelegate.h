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
    // data from "Data.plist"
    NSMutableDictionary *data;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

//@property (nonatomic, retain) NSDate *nameChanged;
//@property (nonatomic, retain) NSDate *favoritesChanged;

@property (nonatomic) BOOL randomViewNeedsUpdate;
@property (nonatomic) BOOL listViewNeedsUpdate;
@property (nonatomic) BOOL favorteViewNeedsUpdate;

// data
- (void)loadDataFile;
- (void)saveDataFile;

// facts
- (NSArray*)factsFromData;
- (NSString*)factFromDataWithId:(NSInteger)id;

// favorite management
- (NSArray*)favoritesFromData;
- (BOOL)factIdIsFavorite:(NSInteger)thisFactId;
- (BOOL)toggleFavoriteForFactId:(NSInteger)thisFactId;

// name management
- (NSString*)nameFromData;
- (void)setNameFromData:(NSString*)thisName;

@end