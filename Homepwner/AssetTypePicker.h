//
//  AssetTypePicker.h
//  Homepwner
//
//  Created by Stephen Looney on 7/15/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BNRItem;

@interface AssetTypePicker : UITableViewController

@property (nonatomic, strong) BNRItem *item;

@end
