//
//  ImageViewController.m
//  Homepwner
//
//  Created by Stephen Looney on 7/2/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "ImageViewController.h"

@implementation ImageViewController

@synthesize image;

- (void)viewWillAPpear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGSize sz = [[self image] size];
    [scrollView setContentSize:sz];
    [imageView setFrame:CGRectMake(0, 0, sz.width, sz.height)];
    
    [imageView setImage:[self image]];
}

@end
