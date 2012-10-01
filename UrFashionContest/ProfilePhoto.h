//
//  ProfilePhoto.h
//  UrFashionContest
//
//  Created by Apple on 9/20/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfilePhoto : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    NSTimer *timer;
    NSData *image;
    double process;
    BOOL check_profile;
}
@property (weak, nonatomic) IBOutlet UIScrollView *ProfilePhotoView;
- (IBAction)btnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *photoViwer;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBarUpload;
- (IBAction)btnBrowse:(id)sender;
- (IBAction)btnSave:(id)sender;


@end
