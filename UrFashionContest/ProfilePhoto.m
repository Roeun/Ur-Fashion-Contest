//
//  ProfilePhoto.m
//  UrFashionContest
//
//  Created by Apple on 9/20/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import "ProfilePhoto.h"
#import "MainClass.h"
#import "User.h"

@interface ProfilePhoto ()

@end



@implementation ProfilePhoto



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_all.jpeg"]];
    self.ProfilePhotoView.backgroundColor = [UIColor whiteColor];
    
    NSArray * user_data = [[MainClass alloc] readTmpFile];
    NSString * imageUrl = [[[MainClass alloc] init] host];
    if ([[user_data objectAtIndex:7] isEqualToString:@""]) {
        imageUrl = [imageUrl stringByAppendingFormat:@"upload/%s", "user.png"];
    }
    else {
        imageUrl = [imageUrl stringByAppendingFormat:@"upload/%@", [user_data objectAtIndex:7]];
    }
    
    NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
    self.photoViwer.image = [UIImage imageWithData:imageData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setProfilePhotoView:nil];
    [self setPhotoViwer:nil];
    [self setProgressBarUpload:nil];
    [super viewDidUnload];
}

- (IBAction)btnBack:(id)sender {
    [[MainClass alloc] linkToView:[Menu alloc] CurrentView:self];
}
- (IBAction)btnBrowse:(id)sender {
    UIActionSheet *photoSourcePicker = [[UIActionSheet alloc] initWithTitle:nil
                                                                   delegate:self cancelButtonTitle:@"Cancel"
                                                     destructiveButtonTitle:nil
                                                          otherButtonTitles:	@"Take Photo",
                                        @"Choose from Library",
                                        nil,
                                        nil];
    
    [photoSourcePicker showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)modalView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // when dialog box photo picker show, choose one index
	switch (buttonIndex)
	{
		case 0:
		{
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
                imagePicker.delegate = self;
                imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
                imagePicker.allowsEditing = NO;
                [self presentModalViewController:imagePicker animated:YES];
            }
            else {
                UIAlertView *alert;
                alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                   message:@"This device doesn't have a camera."
                                                  delegate:self cancelButtonTitle:@"Ok"
                                         otherButtonTitles:nil];
                [alert show];
            }
			break;
		}
		case 1:
		{
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
                imagePicker.delegate = self;
                imagePicker.allowsEditing = NO;
                [self presentModalViewController:imagePicker animated:YES];
            }
            else {
                UIAlertView *alert;
                alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                   message:@"This device doesn't support photo libraries."
                                                  delegate:self cancelButtonTitle:@"Ok"
                                         otherButtonTitles:nil];
                [alert show];
            }
			break; 
		}
	}
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissModalViewControllerAnimated:YES];
    
    NSData *imageData = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 0.1);
    UIImage *img = [UIImage imageWithData:imageData];
    image   = imageData;
    [[self photoViwer] setImage:img];
    
}


- (IBAction)btnSave:(id)sender {
    Photo *obj = [[Photo alloc] init];
    NSString * imageName = [NSString stringWithFormat:@"%f.jpg", [[NSDate date] timeIntervalSince1970]];
    
    self.progressBarUpload.alpha = 1;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0/100.0
                                             target:self
                                           selector:@selector(saveProfilePhoto)
                                           userInfo:nil
                                            repeats:YES];
    
    [obj moveUploadFile:image NameofImage:imageName];
    
    User *objUser = [[User alloc] init];
    NSArray * user_data = [[MainClass alloc] readTmpFile];
    objUser.picture = imageName;
    check_profile = [objUser saveProfilePhotoUserID: [user_data objectAtIndex:0]];
}

- (void) saveProfilePhoto {
    process = process + 0.01;
    self.progressBarUpload.progress = process;
    if (process>1) {
        process = 0;
        [timer invalidate];
        timer = nil;
        self.progressBarUpload.alpha = 0;
        if (check_profile == YES) {
            UIAlertView * msg = [[UIAlertView alloc] initWithTitle:@"Successful" message:@"You have upload profile photo successful" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil , nil];
            [msg show];
        }
        else {
            UIAlertView * msg = [[UIAlertView alloc] initWithTitle:@"Fail" message:@"You have problem with upload photo" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil , nil];
            [msg show];
        }
    }
}
@end
