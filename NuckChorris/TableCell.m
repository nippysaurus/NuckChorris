//
//  TableCell.m
//  ChuckNorrisFacts
//
//  Created by Michael Dawson
//  Copyright (c) 2010 Nippysaurus. All rights reserved.
//

#import "TableCell.h"

@interface TableCell ()

- (void)adjustSize;
- (void)applyFavoriteFormattingWithAnimation:(BOOL)animate;

- (void)sendSelectNotification;
- (void)sendDeselectNotification;

@end

@implementation TableCell

// http://stackoverflow.com/questions/3344341/uibutton-inside-a-view-that-has-a-uitapgesturerecognizer

@synthesize label = _label;
@synthesize favoriteButton = _favoriteButton;
@synthesize shareButton = _shareButton;
@synthesize decorativeLayer = _decorativeLayer;

#pragma mark - Memory Management

- (id)initWithCoder:(NSCoder *)coder
{
    if ((self = [super initWithCoder:coder]))
    {        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
                
        // TODO maybe register the tap gesture and do nothing with it so that the uitableview doesnt try to select this cell?
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ignoreTap)];
        tapGestureRecognizer.delegate = self;
        [self addGestureRecognizer:tapGestureRecognizer];
        [tapGestureRecognizer release];        
        
        // long press
        UILongPressGestureRecognizer *longPressGestureRecognier = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTap:)];
        [self addGestureRecognizer:longPressGestureRecognier];
        [longPressGestureRecognier release];
        
        // swipe right
        UISwipeGestureRecognizer *revealControlsSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(sendSelectNotification)];
        revealControlsSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:revealControlsSwipeRecognizer];
        [revealControlsSwipeRecognizer release];

        // swipe left
        UISwipeGestureRecognizer *concealControlsSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(sendDeselectNotification)];
        concealControlsSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:concealControlsSwipeRecognizer];
        [concealControlsSwipeRecognizer release];
    }
    
    return self;
}

- (void)dealloc
{
    self.favoriteButton = nil;
    self.shareButton = nil;
    
    [_decorativeLayer release];
    
    [super dealloc];
}

#pragma mark - Fact Stuff

- (void)setFactId:(NSInteger)thisFactId factString:(NSString*)thisFactString
{
    self->factId = thisFactId;
    self->factText = thisFactString;
    
    [self.label setText:thisFactString];    
    [self adjustSize];
    
    [self applyFavoriteFormattingWithAnimation:NO];
}

- (void)applyFavoriteFormattingWithAnimation:(BOOL)animate
{
    FavoriteManager *favoriteManager = [FavoriteManager sharedInstance];
    
    BOOL favorite = [favoriteManager factIdIsFavorite:self->factId];
    
    UIImage *favoriteButtonBackgroundImage = nil;
    UIColor *color = nil;
    
    if (favorite == YES)
    {
        // favoritebutton background image
        favoriteButtonBackgroundImage = [UIImage imageNamed:@"Favorite.png"];
        
        color = [UIColor colorWithRed:0.882 green:0.882 blue:0.882 alpha:1.0];
        //225
        //color = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
    }
    else
    {
        // favoritebutton background image
        favoriteButtonBackgroundImage = [UIImage imageNamed:@"FavoriteSelected.png"];

        color = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    }
 
    void (^animations)(void) = ^{
        self.decorativeLayer.backgroundColor = color;
    };

    void (^completion)(BOOL) = ^(BOOL completed){
        [self.favoriteButton setBackgroundImage:favoriteButtonBackgroundImage forState:UIControlStateNormal];
    };
    
    NSTimeInterval duration = animate == YES ? 0.2 : 0.0;
    
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:animations
                     completion:completion];
}

- (NSInteger)factId
{
    return self->factId;
}

- (NSString*)factText
{
    return self->factText;
}

#pragma mark - bla

// private
+ (CGSize)sizeForFact:(NSString*)fact
{
	CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN_LEFT + CELL_CONTENT_MARGIN_RIGHT), 20000.0f);
	
	CGSize size = [fact sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:FONT_SIZE]
                   constrainedToSize:constraint
                       lineBreakMode:UILineBreakModeWordWrap];
    
    return size;
}

- (void)adjustSize
{
    CGSize size = [TableCell sizeForFact:self->factText];
	
    //UILabel *label = (UILabel*)[self viewWithTag:LABEL_TAG];
    
	//[self.label setText:fact];
	[self.label setFrame:CGRectMake(CELL_CONTENT_MARGIN_LEFT, CELL_CONTENT_MARGIN_TOP, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN_LEFT + CELL_CONTENT_MARGIN_RIGHT), MAX(size.height, 2.0f))];
}

+ (CGFloat)cellHeightForFact:(NSString*)fact
{
    CGSize size = [TableCell sizeForFact:fact];
    
	CGFloat height = MAX(size.height, 2.0f);
	
    return height + CELL_CONTENT_MARGIN_TOP + CELL_CONTENT_MARGIN_BOTTOM;
}

-(void)revealControls
{
    // enable all buttons
    self.favoriteButton.enabled = YES;
    self.shareButton.enabled = YES;
        
    CGRect offset = CGRectMake(150, self.label.frame.origin.y, self.label.frame.size.width, self.label.frame.size.height);
    
    void (^animations)(void) = ^{
        self.label.frame = offset;
        self.label.alpha = 0.0;
        
        self.favoriteButton.alpha = 1.0;
        self.shareButton.alpha = 1.0;
    };
    
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:animations
                     completion:nil];
}

-(void)concealControls
{
    // disable all buttons
    self.favoriteButton.enabled = NO;
    self.shareButton.enabled = NO;
    
    CGRect offset = CGRectMake(CELL_CONTENT_MARGIN_LEFT, self.label.frame.origin.y, self.label.frame.size.width, self.label.frame.size.height);
    
    void (^animations)(void) = ^{
        self.label.frame = offset;
        self.label.alpha = 1.0;
        
        self.favoriteButton.alpha = 0.0;
        self.shareButton.alpha = 0.0;
    };
    
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:animations
                     completion:nil];
}

#pragma mark - UITableViewCell Overrides / Selection

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{    
    [super setSelected:selected animated:animated];
    
    if (selected == YES)
        [self revealControls];
 
    if (selected == NO)
        [self concealControls];
}

- (void)sendSelectNotification
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
            self, @"Cell", nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectCell"
                                                        object:self.superview
                                                      userInfo:userInfo];
}

- (void)sendDeselectNotification
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                              self, @"Cell", nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DeselectCell"
                                                        object:self.superview
                                                      userInfo:userInfo];
}

#pragma mark - Cell Hidden Menu Commands

- (IBAction)performToggleFavorite:(id)sender
{
    NuckChorrisAppDelegate *app = (NuckChorrisAppDelegate*)[UIApplication sharedApplication].delegate;

    // temp
    UIView* superview = [self superview];
    
    app.randomViewNeedsUpdate = YES;
    
    if (superview.tag == 14)
    {
        app.favorteViewNeedsUpdate = YES;
        app.listViewNeedsUpdate = YES;
    }
    
    if (superview.tag == 16)
    {
        app.favorteViewNeedsUpdate = YES;
        app.listViewNeedsUpdate = YES;
    }
    
    FavoriteManager *favoritesManager = [FavoriteManager sharedInstance];
    
    [favoritesManager toggleFavoriteForFactId:self->factId];
    
    [self applyFavoriteFormattingWithAnimation:YES];
    
    NSLog(@"perform toggle favorite");
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                              self, @"Cell", nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DeselectCell"
                                                        object:self.superview
                                                      userInfo:userInfo];
}

- (IBAction)performShare:(id)sender
{
    // post to facebook
    NSString *someText = self->factText;
    SHKItem *item = [SHKItem text:someText];
    
	// Get the ShareKit action sheet
    NuckChorrisAppDelegate *app = (NuckChorrisAppDelegate*)[UIApplication sharedApplication].delegate;
	SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
	[actionSheet showInView:app.tabBarController.view];
    
    [self setSelected:NO];
}

#pragma mark - Copy Menu

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(copy:))
    {
        return YES;
    }
    return NO;
}

- (IBAction)copy:(id)sender
{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.factText;
}

#pragma mark - long press handler

- (void)longTap:(UILongPressGestureRecognizer*)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        CGRect rgre = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
        [self becomeFirstResponder];
        [[UIMenuController sharedMenuController] update];
        [[UIMenuController sharedMenuController] setTargetRect:rgre inView:self];
        [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
    }
}

- (void)ignoreTap
{
    //
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch
{
    CGPoint a = [touch locationInView:self.favoriteButton];
    CGPoint b = [touch locationInView:self.shareButton];
    
    BOOL aa = [self.favoriteButton pointInside:a withEvent:nil];
    BOOL bb = [self.shareButton pointInside:b withEvent:nil];

    BOOL filterTap = aa == NO && bb == NO;
    
//    NSLog(@"filterTap = %@", (filterTap == YES ? @"YES" : @"NO"));

    return filterTap;
}

@end