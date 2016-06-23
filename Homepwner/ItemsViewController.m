//
//  ItemsViewController.m
//  Homepwner
//
//  Created by Stephen Looney on 12/14/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "ItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"
#import "HomepwnerItemCell.h"
#import "BNRImageStore.h"
#import "ImageViewController.h"

@implementation ItemsViewController

- (id)init{
    
    // Call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        UINavigationItem *n = [self navigationItem];
        
        [n setTitle:@"Inventory"];
        
        // Create a new bar button item that will send
        // addNewItem to ItemsViewController
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                target:self
                                action:@selector(addNewItem:)];
        
        // Set this bar button item as the right item in the navigationItem
        [[self navigationItem] setRightBarButtonItem:bbi];
        
        [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
    }
    NSLog(@"init itemsViewController finished calling");
    
    
    // Blur View Initialization
    
    
    
    backgroundImageView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    
    backgroundImageView.frame = CGRectMake(0, 0, self.view.frame.size.width + 60.0, self.view.frame.size.height + 60.0);
    
    // Below adds the background image scroll view, then sends it beneath the blur view
    [self.tableView addSubview:backgroundImageView];
    [self.tableView sendSubviewToBack:backgroundImageView];
    self.tableView.clipsToBounds = YES;
    
    UIColor *tiledBackground = [UIColor colorWithPatternImage:[UIImage imageNamed:@"itemsBackground"]];
    
    backgroundImageView.backgroundColor = tiledBackground;

    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        
        UIVisualEffect *blurEffect;
        blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        
        UIVisualEffectView *visualEffectView;
        visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        
        visualEffectView.frame = self.view.bounds;
        visualEffectView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        visualEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        // Below adds the view, then sends it to the back
        [backgroundImageView addSubview:visualEffectView];
        [backgroundImageView sendSubviewToBack:visualEffectView];
        
    }
    
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}


-(void) viewDidLoad {
    [super viewDidLoad];
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    // when i put header, the table vanishes and is not visible now
    //UIView *header = self.headerView;
    //[self.tableView setTableHeaderView:header];
    
    // Load the NIB file
    UINib *nib = [UINib nibWithNibName:@"HomepwnerItemCell" bundle:nil];
    
    // Register this NIB which contains the cell
    [self.tableView registerNib:nib
           forCellReuseIdentifier:@"HomepwnerItemCell"];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /*
    if !UIAccessibilityIsReduceTransparencyEnabled() {
        //chatView.backgroundColor = UIColor.clearColor()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        //always fill the view
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        view.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
        view.sendSubviewToBack(blurEffectView)
    }
    */
    
    /*
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"itemsBackground"]]];
    
    [self.view bringSubviewToFront:itemsTableView];
    */
    
    
    
    
    [self.tableView reloadData];
}

#pragma mark - TableView Protocol

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Calling rows in section tableView protocol");
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[[BNRItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"Calling cell for row at index path tableView protocol");
    
    
    // Set the text on the cell with the description of the item
    // that is at the nth index of items, where n = row this cell
    // will appear in on the tableview
    
    BNRItem *p = [[[BNRItemStore sharedStore] allItems] objectAtIndex:[indexPath section]];
    
    // Get the new or recycled cell
    HomepwnerItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomepwnerItemCell"];
    
    [cell setController:self];
    [cell setTableView:tableView];
    
    // Configure the cell with the BNRItem
    [[cell nameLabel] setText:[p itemName]];
    [[cell serialNumberLabel] setText:[p serialNumber]];
    [[cell valueLabel] setText:[NSString stringWithFormat:@"$%d", [p valueInDollars]]];
    [[cell thumbnailView] setImage:[p thumbnail]];
    
    return cell;
}


- (void)tableView:(UITableView *)aTableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailViewController = [[DetailViewController alloc] initForNewItem:NO];
    
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *selectedItem = [items objectAtIndex:[indexPath section]];
    
    // Give detail view controller a pointer to the item object in row
    [detailViewController setItem:selectedItem];
    
    // Push it onto the top of the navigation controller's stack
    [[self navigationController] pushViewController:detailViewController
                                           animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 4.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 6.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.0;
}

/* The following code shows how to define the header view cell in a UITableView. This will possibly be useful for PoopTime
 
 
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSLog(@"headerView being set as the header view of the tableView");
    return [self headerView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    // The height of the header view should be determined from the height of the
    // view in the XIB file
    NSLog(@"Height for header being set");
    return [[self headerView] bounds].size.height;
}



- (UIView *)headerView
{
    // If we haven't loaded the headerView yet...
    if (!headerView) {
        // Load HeaderView.xib
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
    }
    NSLog(@"headerView initialized");
    return headerView;
}


- (IBAction)toggleEditingMode:(id)sender
{
    // If we are currently in editing mode...
    if ([self isEditing]) {
        // Change text of button to inform user of state
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        // Turn off editing mode
        [self setEditing:NO animated:YES];
    } else {
        // Change text of button to inform user of state
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        //Enter editing mode
        [self setEditing:YES animated:YES];
    }
}
 */

- (IBAction)addNewItem:(id)sender
{
    // Create a new BNRItem and add it to the store
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
    
    /*  Commenting out the code below to present the nav conroller modally instead of only adding to the tableView
     
    // Figure out where that item is in the array
    int lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];
    
    NSIndexPath *ip = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    // Insert this new row into a table
    [[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:ip] withRowAnimation:UITableViewRowAnimationTop];
     
     */
    
    DetailViewController *detailViewController = [[DetailViewController alloc] initForNewItem:YES];
    
    [detailViewController setItem:newItem];
    
    [detailViewController setDismissBlock:^{
        [self.tableView reloadData];
    }];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    
    [navController setModalPresentationStyle:UIModalPresentationFormSheet];
    //[navController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    [self presentViewController:navController animated:YES completion:nil];
    
    
}

- (void)showImage:(id)sender atIndexPath:(NSIndexPath *)ip
{
    NSLog(@"Going to show the image for %@", ip);
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        // Get the item for the index path
        BNRItem *i = [[[BNRItemStore sharedStore] allItems] objectAtIndex:[ip row]];
        
        NSString *imageKey = [i imageKey];
        
        // If there is no image, we don't need to display anything
        UIImage *img = [[BNRImageStore sharedStore] imageForKey:imageKey];
        if (!img)
            return;
        
        // Make a rectangle that the frame of the button relative to our tableView
        CGRect rect = [[self view] convertRect:[sender bounds] fromView:sender];
        
        // Create a new ImageViewController and set its image
        ImageViewController *ivc = [[ImageViewController alloc] init];
        [ivc setImage:img];
        
        // Present a 600x600 popover from the rect
        imagePopover = [[UIPopoverController alloc] initWithContentViewController:ivc];
        [imagePopover setDelegate:self];
        [imagePopover setPopoverContentSize:CGSizeMake(600, 600)];
        
        [imagePopover presentPopoverFromRect:rect
                                      inView:[self view]
                    permittedArrowDirections:UIPopoverArrowDirectionAny
                                    animated:YES];
    }
}

#pragma mark - TableView editing methods

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // If the table view is asking to commit a delete command...
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        BNRItemStore *ps = [BNRItemStore sharedStore];
        NSArray *items = [ps allItems];
        BNRItem *p = [items objectAtIndex:[indexPath row]];
        [ps removeItem:p];
        
        // We also remove that row from the table view with an animation
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[BNRItemStore sharedStore] moveItemAtIndex:[sourceIndexPath row]
                                        toIndex:[destinationIndexPath row]];
}

- (BOOL)shouldAutorotate {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        return YES;
        
    } else {
        
        return NO;
        
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [imagePopover dismissPopoverAnimated:YES];
    imagePopover = nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView //This fixes the tiled background image
{
    CGRect fixedFrame = backgroundImageView.frame;
    fixedFrame.origin.y = (20 + scrollView.contentOffset.y);// - (scrollView.contentOffset.y)/5.0f;
    //fixedFrame.origin.x = -20;
    backgroundImageView.frame = fixedFrame;
}

@end
