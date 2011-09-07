//
//  FavoritesViewController.m
//  NuckChorris
//
//  Created by Michael Dawson on 20/07/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import "FavoritesViewController.h"

@implementation FavoritesViewController

@synthesize tableView = _tableView;
@synthesize nibLoadedCell = _nibLoadedCell;
@synthesize hiddenMessage = _hiddenMessage;

#pragma mark - Memory Management

- (void)dealloc
{
    self.tableView = nil;
    self.hiddenMessage = nil;
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NuckChorrisAppDelegate *app = (NuckChorrisAppDelegate*)[UIApplication sharedApplication].delegate;
    
    NSInteger rows = (NSInteger)[[app favoritesFromData] count];
 
    // show or hide the table view to reveal (or hide) the hidden message
    self.hiddenMessage.hidden = (rows != 0);
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NuckChorrisAppDelegate *app = (NuckChorrisAppDelegate*)[UIApplication sharedApplication].delegate;
    
    TableCell* cell = (TableCell*)[tableView dequeueReusableCellWithIdentifier:@"FavoritesTableCell"];
    
    if (cell == nil)
    {
		[[NSBundle mainBundle] loadNibNamed:@"TableCell"
									  owner:self
									options:NULL];
        
        [self.nibLoadedCell retain];
        
		cell = (TableCell*)self.nibLoadedCell;
    }
    
    // lookup the fact id from the favourites collection
    NSInteger index = indexPath.row;
    NSArray *favourite_fact_ids = [app favoritesFromData];
    NSNumber *favourite_fact_id = [favourite_fact_ids objectAtIndex:index];
    NSInteger favourite_fact_id_int = [favourite_fact_id intValue];
    
    NSString *factText = [app factFromDataWithId:favourite_fact_id_int];
    
    [cell setFactId:favourite_fact_id_int factString:factText];
    
	return cell;
}

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NuckChorrisAppDelegate *app = (NuckChorrisAppDelegate*)[UIApplication sharedApplication].delegate;

    // lookup the fact id from the favourites collection
    NSInteger index = indexPath.row;
    NSArray *favourite_fact_ids = [app favoritesFromData];
    NSNumber *favourite_fact_id = [favourite_fact_ids objectAtIndex:index];
    NSInteger favourite_fact_id_int = [favourite_fact_id intValue];
    
    NSString *fact = [app factFromDataWithId:favourite_fact_id_int];
    
	return [TableCell cellHeightForFact:fact];
}

#pragma mark - Cell Selection

-(void)selectCell:(NSNotification*)notification
{
    NSDictionary *userInfo = notification.userInfo;
    
    UITableViewCell *cell = [userInfo objectForKey:@"Cell"];
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    // dont worry if already selected
    if (cell.selected == YES)
        return;
    
    [self.tableView selectRowAtIndexPath:indexPath
                                animated:YES
                          scrollPosition:UITableViewScrollPositionNone];
}

-(void)deselectCell:(NSNotification*)notification
{
    NSDictionary *userInfo = notification.userInfo;
    
    UITableViewCell *cell = [userInfo objectForKey:@"Cell"];
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    // dont worry if already deselected
    if (cell.selected == NO)
        return;
    
    [self.tableView deselectRowAtIndexPath:indexPath
                                  animated:YES];
}

- (void)scrollViewDidScroll:(UITableView *)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    // dont worry if already deselected
    if (indexPath == nil)
        return;
    
    [self.tableView deselectRowAtIndexPath:indexPath
                                  animated:YES];
}
#pragma mark - Table view delegate

- (NSIndexPath*)tableView:(UITableView*)tableView willSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    return indexPath;
}

#pragma mark - Other

- (void)viewWillAppear:(BOOL)animated
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(selectCell:)
                                                 name:@"SelectCell"
                                               object:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deselectCell:)
                                                 name:@"DeselectCell"
                                               object:self.tableView];
    
    NuckChorrisAppDelegate *app = (NuckChorrisAppDelegate*)[UIApplication sharedApplication].delegate;

    if (app.favorteViewNeedsUpdate == YES)
    {
        [self.tableView reloadData];
        
        app.favorteViewNeedsUpdate = NO;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    NSString *firstTimeKey = @"favorites_tab_first_time";
    
    NSString *firstTime = [[NSUserDefaults standardUserDefaults] stringForKey:firstTimeKey];
    
    if (firstTime == nil)
    {        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Welcome"
                              message: @"This is the \"Favorites\" tab. Only items which you have marked as favorite (with the red heart) will appear here."
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

- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setHiddenMessage:nil];
    [super viewDidUnload];
}

@end