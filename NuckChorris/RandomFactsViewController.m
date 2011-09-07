//
//  RandomFactsViewController.m
//  NuckChorris
//
//  Created by Michael Dawson on 26/06/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import "RandomFactsViewController.h"

@interface RandomFactsViewController ()

- (void)showRandomFactId:(NSInteger)thisId;
- (void)showNextRandomFact;

@end

@implementation RandomFactsViewController

@synthesize randomFactViewFromNib = _randomFactViewFromNib;

#pragma mark - Memory Management

- (void)dealloc
{    
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // load random fact view
    [[NSBundle mainBundle] loadNibNamed:@"RandomFact" owner:self options:NULL];
    self.randomFactViewFromNib.frame = CGRectMake(20, 120, 280, 50);
    self.randomFactViewFromNib.factId = -1;
    [self.view addSubview:self.randomFactViewFromNib];
        
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self.randomFactViewFromNib action:@selector(showControls)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    [swipeRight release];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self.randomFactViewFromNib action:@selector(hideControls)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    [swipeLeft release];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showNextRandomFact)];
    tapGesture.delegate = self.randomFactViewFromNib;
    [self.view addGestureRecognizer:tapGesture];
    [tapGesture release];
    
	// initial random fact
	[self showNextRandomFact];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"view will appear");

    NuckChorrisAppDelegate *app = (NuckChorrisAppDelegate*)[UIApplication sharedApplication].delegate;
    
    if (app.randomViewNeedsUpdate == YES)
    {
        NSLog(@"redisplaying data");
        
        [self showRandomFactId:self.randomFactViewFromNib.factId];
        
        app.randomViewNeedsUpdate = NO;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    NSString *firstTimeKey = @"random_tab_first_time";
    
    NSString *firstTime = [[NSUserDefaults standardUserDefaults] stringForKey:firstTimeKey];
    
    if (firstTime == nil)
    {        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Welcome"
                              message: @"This is the \"Random\" tab. Tap the screen to show another fact. Swipe to the right to reveal sharing controls, and swipe left to hide them again."
                              delegate: nil
                              cancelButtonTitle:@"Thank You"
                              otherButtonTitles:nil];
        
        [alert show];
        [alert release];
    }
    
    // if this user default has not been set then it will be zero
    [[NSUserDefaults standardUserDefaults] setValue:@"something" forKey:firstTimeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Fact Management

- (void)showRandomFactId:(NSInteger)thisId
{
    NuckChorrisAppDelegate *app = (NuckChorrisAppDelegate*)[UIApplication sharedApplication].delegate;
    
    self.randomFactViewFromNib.factId = thisId;
    self.randomFactViewFromNib.factText = [app factFromDataWithId:thisId];
    
    // ==================
    
	CGSize constraint = CGSizeMake(280.0f - (0 + 0), 20000.0f);
	
	CGSize size = [self.randomFactViewFromNib.factText sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:15.0f]
                                                  constrainedToSize:constraint
                                                      lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat height = MAX(size.height, 2.0f);
    

    // "self.view.frame.height" will be 460 the first time, then 411 every other time
    //CGFloat y = (self.view.frame.size.height / 2) - (height / 2);
    //CGFloat y = (411 / 2) - (height / 2);
    CGFloat y = 150;

    //NSLog(@"self.view.frame.height = %f", self.view.frame.size.height);
    
    CGRect oldRect = self.randomFactViewFromNib.frame;
    CGRect newRect = CGRectMake(oldRect.origin.x, y, oldRect.size.width, height);
    
    self.randomFactViewFromNib.frame = newRect;
}

- (void)showNextRandomFact
{
    NuckChorrisAppDelegate *app = (NuckChorrisAppDelegate*)[UIApplication sharedApplication].delegate;
    
    // get random fact id
    
    int count = [app.factsFromData count];
    
    if (count == 0)
        return;
  
    NSInteger currentFactId = self.randomFactViewFromNib.factId;
    
    int generated = self.randomFactViewFromNib.factId;
    
    // prevent the same "random" fact from appearing twice in a row
    while (generated == currentFactId)
        generated = (random() % count);
    
    // set the text (gui)

    [self showRandomFactId:generated];
}

@end