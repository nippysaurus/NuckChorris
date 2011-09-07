//
//  ALTabBarView.m
//  ALCommon
//
//  Created by Andrew Little on 10-08-17.
//  Copyright (c) 2010 Little Apps - www.myroles.ca. All rights reserved.
//

#import "ALTabBarView.h"


@implementation ALTabBarView

@synthesize delegate;
@synthesize selectedButton;

- (void)dealloc
{    
    [selectedButton release];
    
    delegate = nil;
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        // Initialization code
        //self.selectedButton = (UIButton*)[self viewWithTag:0];
    }
    return self;
}

//Let the delegate know that a tab has been touched
-(IBAction) touchButton:(id)sender {

    if( delegate != nil && [delegate respondsToSelector:@selector(tabWasSelected:)]) {
        
        if (selectedButton != NULL)
        {
            NSLog(@"deselecting %d", selectedButton.tag);
            
            UIImage *image = NULL;
            
            if (selectedButton.tag == 10)
                image = [UIImage imageNamed:@"Random.png"];

            if (selectedButton.tag == 20)
                image = [UIImage imageNamed:@"List.png"];
            
            if (selectedButton.tag == 30)
                image = [UIImage imageNamed:@"Favorites.png"];
            
            if (selectedButton.tag == 40)
                image = [UIImage imageNamed:@"Settings.png"];
            
            [selectedButton setBackgroundImage:image forState:UIControlStateNormal];
            [selectedButton release];
        }
        
        NSLog(@"selecting %d", selectedButton.tag);
        
        selectedButton = [((UIButton *)sender) retain];
        
        UIImage *image = NULL;
        
        if (selectedButton.tag == 10)
        {
            image = [UIImage imageNamed:@"RandomSelected.png"];
            [selectedButton setBackgroundImage:image forState:UIControlStateNormal];
            [delegate tabWasSelected:0];
        }
        
        if (selectedButton.tag == 20)
        {
            image = [UIImage imageNamed:@"ListSelected.png"];
            [selectedButton setBackgroundImage:image forState:UIControlStateNormal];
            [delegate tabWasSelected:1];
        }
        
        if (selectedButton.tag == 30)
        {
            image = [UIImage imageNamed:@"FavoritesSelected.png"];
            [selectedButton setBackgroundImage:image forState:UIControlStateNormal];
            [delegate tabWasSelected:2];
        }
        
        if (selectedButton.tag == 40)
        {
            image = [UIImage imageNamed:@"SettingsSelected.png"];
            [selectedButton setBackgroundImage:image forState:UIControlStateNormal];
            [delegate tabWasSelected:3];
        }
        
//        [selectedButton setBackgroundImage:image forState:UIControlStateNormal];
//        [delegate tabWasSelected:selectedButton.tag];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
