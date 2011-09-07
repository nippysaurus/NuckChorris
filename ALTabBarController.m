//
//  ALTabBarController.m
//  ALCommon
//
//  Created by Andrew Little on 10-08-17.
//  Copyright (c) 2010 Little Apps - www.myroles.ca. All rights reserved.
//

#import "ALTabBarController.h"


@implementation ALTabBarController

@synthesize customTabBarView;

- (void)dealloc {
    
    [customTabBarView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [self hideExistingTabBar];
    
    NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"TabBarView" owner:self options:nil];
    self.customTabBarView = [nibObjects objectAtIndex:0];
    self.customTabBarView.delegate = self;
    
    // modify frame
    CGRect original = self.customTabBarView.frame;
    CGRect lnegrkjn = CGRectMake(original.origin.x, self.view.frame.size.height - original.size.height, original.size.width, original.size.height);
    
    self.customTabBarView.frame = lnegrkjn;
    
    [self.view addSubview:self.customTabBarView];
    
    // select the first tab
    UIButton* button = (UIButton*)[self.customTabBarView viewWithTag:10];
    [self.customTabBarView touchButton:button];
    
    // add the corner images
    
//    UIImageView *leftCorner = [nibObjects objectAtIndex:1];
//    CGRect leftCornerFrame = CGRectMake(0, self.view.frame.size.height - original.size.height - leftCorner.frame.size.height, leftCorner.frame.size.width, leftCorner.frame.size.height);
//    leftCorner.frame = leftCornerFrame;
//    [self.view addSubview:leftCorner];
//    
//    UIImageView *rightCorner = [nibObjects objectAtIndex:2];
//    CGRect rightCornerFrame = CGRectMake(self.view.frame.size.width - rightCorner.frame.size.width, self.view.frame.size.height - original.size.height - leftCorner.frame.size.height, leftCorner.frame.size.width, leftCorner.frame.size.height);
//    rightCorner.frame = rightCornerFrame;
//    [self.view addSubview:rightCorner];
}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//}

- (void)hideExistingTabBar
{
	for(UIView *view in self.view.subviews)
	{
		if([view isKindOfClass:[UITabBar class]])
		{
			view.hidden = YES;
			break;
		}
	}
}

#pragma mark ALTabBarDelegate

-(void)tabWasSelected:(NSInteger)index {
 
    self.selectedIndex = index;
}


@end