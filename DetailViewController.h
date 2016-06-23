//
//  DetailViewController.h
//  Homepwner
//
//  Created by Stephen Looney on 1/24/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface DetailViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UIPopoverControllerDelegate>

{
    __weak IBOutlet UITextField *nameField;
    __weak IBOutlet UITextField *serialNumberField;
    __weak IBOutlet UITextField *valueField;
    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UIImageView *imageView;
    __weak IBOutlet UIButton *assetTypeButton;
    
    
    UIPopoverController *imagePickerPopover;
}

@property (nonatomic, strong) BNRItem *item;

@property (nonatomic, copy) void (^dismissBlock)(void);

- (id)initForNewItem:(BOOL)isNew;

- (IBAction)takePicture:(id)sender;

- (IBAction)backgroundTapped:(id)sender;
- (IBAction)showAssetTypePicker:(id)sender;

@end
