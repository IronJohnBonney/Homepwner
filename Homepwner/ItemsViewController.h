//
//  ItemsViewController.h
//  Homepwner
//
//  Created by Stephen Looney on 12/14/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface ItemsViewController : UITableViewController <UIPopoverControllerDelegate>

{
   // IBOutlet UIView *headerView;  For defining the UITableView header view
    UIScrollView *backgroundImageView;
    UIPopoverController *imagePopover;
    
}

// - (UIView *)headerView;  For defining UITableView header view
- (IBAction)addNewItem:(id)sender;
// - (IBAction)toggleEditingMode:(id)sender; For defining UITableView header view

@end
