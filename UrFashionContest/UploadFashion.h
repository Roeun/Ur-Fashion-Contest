//
//  UploadFashion.h
//  UrFashionContest
//
//  Created by Apple on 9/20/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadFashion : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *UploadFashionView;
@property (weak, nonatomic) IBOutlet UITextView *txtFashionDescription;
@property (weak, nonatomic) IBOutlet UIImageView *PhotoFashionView;
@property (weak, nonatomic) IBOutlet UIButton *btnFashionPhoto;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBarUpload;

- (IBAction)btnBack:(id)sender;
- (IBAction)btnFashionPhoto:(id)sender;

@end
