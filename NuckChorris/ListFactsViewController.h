//
//  ListFactsViewController.h
//  NuckChorris
//
//  Created by Michael Dawson on 26/06/11.
//  Copyright 2011 Nippysaurus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NuckChorrisAppDelegate.h"
#import "TableCell.h"
#import "FactManager.h"

@interface ListFactsViewController : UIViewController /*UITableViewController*/ <UIScrollViewDelegate, UITableViewDataSource>
{
    //
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) UITableViewCell *nibLoadedCell;

@end