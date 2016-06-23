//
//  ImageViewController.h
//  Homepwner
//
//  Created by Stephen Looney on 7/2/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController

{
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIImageView *imageView;
}
@property (nonatomic, strong) UIImage *image;

@end
