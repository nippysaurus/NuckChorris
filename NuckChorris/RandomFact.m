//
//  RandomFact.m
//  NuckChorris
//
//  Created by Michael Dawson on 15/07/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import "RandomFact.h"

@implementation RandomFact

@synthesize factId;

@synthesize factLabel;
@synthesize decorativeLayer;

@synthesize favoriteButton = _favoriteButton;
@synthesize shareButton = _shareButton;

#pragma mark - Memory Management

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    
    if (self)
    {
        NSLog(@"initWithCoder");
        
        controlsShowing = NO;
        
        UILongPressGestureRecognizer *longPressGestureRecognier = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTap:)];
        [self addGestureRecognizer:longPressGestureRecognier];
        [longPressGestureRecognier release];
        
//        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showControls)];
//        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
//        [self addGestureRecognizer:swipeRight];
//        [swipeRight release];
//
//        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hideControls)];
//        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
//        [self addGestureRecognizer:swipeLeft];
//        [swipeLeft release];
//        
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doNothing)];
//        [self addGestureRecognizer:tapGesture];
//        [tapGesture release];
    }
    
    return self;
}

- (void)dealloc
{
    self.factLabel = nil;
    
    [decorativeLayer release];
    [super dealloc];
}

#pragma mark - Show & Hide Controls

- (void)doNothing
{
    NSLog(@"doNothing");
}

- (void)showControls
{
    if (controlsShowing == NO)
    {
        NSLog(@"showControls");
        
        controlsShowing = YES;
        
        CGRect offset = CGRectMake(150, self.factLabel.frame.origin.y, self.factLabel.frame.size.width, self.factLabel.frame.size.height);
        
        void (^animations)(void) = ^{
            self.factLabel.frame = offset;
            self.factLabel.alpha = 0.0;
            
            self.favoriteButton.alpha = 1.0;
            self.shareButton.alpha = 1.0;
        };
        
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:animations
                         completion:nil];
    }
}

- (void)hideControls
{
    if (controlsShowing == YES)
    {
        NSLog(@"hideControls");    
        controlsShowing = NO;
        
        CGRect offset = CGRectMake(8, self.factLabel.frame.origin.y, self.factLabel.frame.size.width, self.factLabel.frame.size.height);
        
        void (^animations)(void) = ^{
            self.factLabel.frame = offset;
            self.factLabel.alpha = 1.0;
            
            self.favoriteButton.alpha = 0.0;
            self.shareButton.alpha = 0.0;
        };
        
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:animations
                         completion:nil];
    }
}

#pragma mark - Text Getter & Setter

- (NSString*)factText
{
    return self.factLabel.text;
}

- (void)setFactText:(NSString *)thisText
{
    if (controlsShowing == YES)
        [self hideControls];
    
    self.factLabel.text = thisText;
    
    [self applyFavoriteFormattingWithAnimation:NO];
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

#pragma mark - wkjbwbhhjbvfkw

//- (void)applyFavoriteFormatting
//{
//    NuckChorrisAppDelegate *app = (NuckChorrisAppDelegate*)[UIApplication sharedApplication].delegate;
//    
//    BOOL favorite = [app factIdIsFavorite:self.factId];
//    
//    UIColor *color = nil;
//    
//    if (favorite == YES)
//        color = [UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0];
//    else
//        color = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
//    
//    self.factLabel.backgroundColor = color;
//}

- (void)applyFavoriteFormattingWithAnimation:(BOOL)animate
{
    NuckChorrisAppDelegate *app = (NuckChorrisAppDelegate*)[UIApplication sharedApplication].delegate;
    
    BOOL favorite = [app factIdIsFavorite:self->factId];
    
    UIImage *favoriteButtonBackgroundImage = nil;
    UIColor *color = nil;
    
    if (favorite == YES)
    {
        // favoritebutton background image
        favoriteButtonBackgroundImage = [UIImage imageNamed:@"Favorite.png"];
        
        //color = [UIColor colorWithRed:0.941 green:0.941 blue:0.941 alpha:1.0];
        //color = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
        color = [UIColor colorWithRed:0.882 green:0.882 blue:0.882 alpha:1.0];
    }
    else
    {
        // favoritebutton background image
        favoriteButtonBackgroundImage = [UIImage imageNamed:@"FavoriteSelected.png"];
        
        color = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    }
    
    void (^animations)(void) = ^{
        //self.factLabel.backgroundColor = color;
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

#pragma mark - Cell Hidden Menu Commands

- (IBAction)performToggleFavorite:(id)sender
{
    NuckChorrisAppDelegate *app = (NuckChorrisAppDelegate*)[UIApplication sharedApplication].delegate;
    
    // temp
    //UIView* superview = [self superview];
    //NSLog(@"%d", superview.tag);
    
    app.favorteViewNeedsUpdate = YES;
    app.listViewNeedsUpdate = YES;

    //app.favoritesChanged = [NSDate date];
    //NSDate *favoritesChanged = [app favoritesChanged];
    
    [app toggleFavoriteForFactId:self->factId];
    
    [self applyFavoriteFormattingWithAnimation:YES];
    
    NSLog(@"perform toggle favorite");
    
    [self hideControls];
}

- (IBAction)performShare:(id)sender
{
    // post to facebook
    NSString *someText = self.factText;
    SHKItem *item = [SHKItem text:someText];
    //    [SHKFacebook shareItem:item];
    
	// Get the ShareKit action sheet
    NuckChorrisAppDelegate *app = (NuckChorrisAppDelegate*)[UIApplication sharedApplication].delegate;
	SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
	[actionSheet showInView:app.tabBarController.view];
    //app.tabBarController
    
    [self hideControls];
    //[self setSelected:NO];
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
        //[[UIMenuController sharedMenuController] setTargetRect:CGRectZero inView:self];
        [[UIMenuController sharedMenuController] setTargetRect:rgre inView:self];
        [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
    }
}

#pragma mark - Gesture Recognisers

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