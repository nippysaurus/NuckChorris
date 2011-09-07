//
//  TableCell.h
//  ChuckNorrisFacts
//
//  Created by Michael Dawson
//  Copyright (c) 2010 Nippysaurus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NuckChorrisAppDelegate.h"
#import "SHK.h"

#define LABEL_TAG 5

#define FONT_SIZE 16.0f
#define CELL_CONTENT_WIDTH 300.0f
#define CELL_CONTENT_MARGIN_LEFT 8.0f
#define CELL_CONTENT_MARGIN_RIGHT 8.0f
#define CELL_CONTENT_MARGIN_TOP 4.0f
#define CELL_CONTENT_MARGIN_BOTTOM 4.0f

@interface TableCell : UITableViewCell <UIGestureRecognizerDelegate>
{
    NSInteger factId;
    NSString *factText;
    
    UIView *_decorativeLayer;
}

@property (nonatomic, retain) IBOutlet UILabel *label;

@property (nonatomic, retain) IBOutlet UIButton *favoriteButton;
@property (nonatomic, retain) IBOutlet UIButton *shareButton;
@property (nonatomic, retain) IBOutlet UIView *decorativeLayer;

+ (CGFloat)cellHeightForFact:(NSString*)fact;

// fact stuff
- (void)setFactId:(NSInteger)thisFactId factString:(NSString*)thisFactString;
- (NSInteger)factId;
- (NSString*)factText;

- (IBAction)performToggleFavorite:(id)sender;
- (IBAction)performShare:(id)sender;

-(void)revealControls;
-(void)concealControls;

@end