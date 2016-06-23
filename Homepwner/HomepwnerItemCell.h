//
//  HomepwnerItemCell.h
//  Homepwner
//
//  Created by Stephen Looney on 7/2/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HomepwnerItemCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@property (weak, nonatomic) id controller;
@property (weak, nonatomic) UITableView *tableView;

- (IBAction)showImage:(id)sender;


@end
