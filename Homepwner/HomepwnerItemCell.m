//
//  HomepwnerItemCell.m
//  Homepwner
//
//  Created by Stephen Looney on 7/2/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "HomepwnerItemCell.h"

@implementation HomepwnerItemCell

@synthesize thumbnailView, nameLabel, serialNumberLabel, valueLabel, controller, tableView;

- (IBAction)showImage:(id)sender
{
    // Get this name of this method "showImage:"
    NSString *selector = NSStringFromSelector(_cmd);
    // selector is now "showImage:atIndexPath:"
    selector = [selector stringByAppendingString:@"atIndexPath:"];
    
    // Prepare a selector from this sting
    SEL newSelector = NSSelectorFromString(selector);
    
    NSIndexPath *indexPath = [[self tableView] indexPathForCell:self];
    if (indexPath) {
        if ([[self controller] respondsToSelector:newSelector]) {
            // Ignore warning for this line - may or may not appear, doesn't matter
            [[self controller] performSelector:newSelector
                                    withObject:sender
                                    withObject:indexPath];
        }
    }
    
    
}

@end
