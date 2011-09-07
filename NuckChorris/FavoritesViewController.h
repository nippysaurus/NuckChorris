//
//  FavoritesViewController.h
//  NuckChorris
//
//  Created by Michael Dawson on 20/07/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NuckChorrisAppDelegate.h"
#import "TableCell.h"

@interface FavoritesViewController : UIViewController /*UITableViewController*/ <UITableViewDataSource>
{
    //
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) UITableViewCell *nibLoadedCell;
@property (nonatomic, retain) IBOutlet UILabel *hiddenMessage;

@end