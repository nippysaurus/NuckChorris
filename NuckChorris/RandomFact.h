//
//  RandomFact.h
//  NuckChorris
//
//  Created by Michael Dawson on 15/07/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavoriteManager.h"

#import "NuckChorrisAppDelegate.h"

@interface RandomFact : UIView <UIGestureRecognizerDelegate>
{
    BOOL controlsShowing;
    UIView *decorativeLayer;
}

@property (nonatomic) NSInteger factId;
@property (retain, nonatomic) NSString *factText;

@property (nonatomic, retain) IBOutlet UILabel *factLabel;

@property (nonatomic, retain) IBOutlet UIView *decorativeLayer;
@property (nonatomic, retain) IBOutlet UIButton *favoriteButton;
@property (nonatomic, retain) IBOutlet UIButton *shareButton;

- (void)showControls;
- (void)hideControls;

// TODO this should be private
//- (void)applyFavoriteFormatting;
- (void)applyFavoriteFormattingWithAnimation:(BOOL)animate;

- (IBAction)performToggleFavorite:(id)sender;
- (IBAction)performShare:(id)sender;

@end