//
//  ListFactsViewController.m
//  NuckChorris
//
//  Created by Michael Dawson on 26/06/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import "ListFactsViewController.h"

@implementation ListFactsViewController

@synthesize tableView = _tableView;
@synthesize nibLoadedCell = _nibLoadedCell;

#pragma mark - Memory Management

- (void)dealloc
{
    self.nibLoadedCell = nil;

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
    
    NSInteger rows = (NSInteger)[app.factsFromData count];
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NuckChorrisAppDelegate *app = (NuckChorrisAppDelegate*)[UIApplication sharedApplication].delegate;
    
    TableCell* cell = (TableCell*)[tableView dequeueReusableCellWithIdentifier:@"ListTableCell"];
    
    if (cell == nil)
    {
		[[NSBundle mainBundle] loadNibNamed:@"TableCell"
									  owner:self
									options:NULL];
        
        [self.nibLoadedCell retain];
        
		cell = (TableCell*)self.nibLoadedCell;
    }
    
    NSInteger factId = indexPath.row;
    NSString *factText = [app factFromDataWithId:factId];
    
    [cell setFactId:factId factString:factText];
    
	return cell;
}

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NuckChorrisAppDelegate *app = (NuckChorrisAppDelegate*)[UIApplication sharedApplication].delegate;
    
    NSString *fact = [app factFromDataWithId:indexPath.row];
    
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

    if (app.listViewNeedsUpdate == YES)
    {
        [self.tableView reloadData];
        
        app.listViewNeedsUpdate = NO;
    }
}

@end