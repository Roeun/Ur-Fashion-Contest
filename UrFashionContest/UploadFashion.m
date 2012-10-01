//
//  UploadFashion.m
//  UrFashionContest
//
//  Created by Apple on 9/20/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import "UploadFashion.h"
#import "MainClass.h"

@interface UploadFashion ()

@end

NSData * image;
BOOL status_upload;
NSTimer * timer;
BOOL check_image = NO;

static double proccess;

@implementation UploadFashion
@synthesize txtFashionDescription;

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
    self.UploadFashionView.backgroundColor = [UIColor grayColor];
    self.UploadFashionView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height *1.4);
    
}

- (void)viewDidUnload
{
    [self setUploadFashionView:nil];
    [self setTxtFashionDescription:nil];
    [self setPhotoFashionView:nil];
    [self setBtnFashionPhoto:nil];
    [self setProgressBarUpload:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)btnBack:(id)sender {
    [[MainClass alloc] linkToView:[Menu alloc] CurrentView:self];
}

- (IBAction)btnFashionPhoto:(id)sender {
    if (check_image == YES) {
        check_image = NO;
        Photo *obj = [Photo alloc];
        obj.pname = [NSString stringWithFormat:@"%f.jpg", [[NSDate date] timeIntervalSince1970]];
        obj.pdes = self.txtFashionDescription.text;
        obj.postDate = [[MainClass alloc] dateToString:[NSDate date]];
        NSArray * user_data = [[MainClass alloc] readTmpFile ];
        obj.uid = [user_data objectAtIndex:0];
        //obj.pdata = image;
        [obj moveUploadFile:image NameofImage:obj.pname];
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0/100.0
                                                   target:self
                                                 selector:@selector(uploadProgressBarProccess)
                                                 userInfo:nil
                                                  repeats:YES];
        status_upload = [obj uploadFashionPhoto];
        self.progressBarUpload.alpha = 1;
    }
    else {
        // photo picker
        UIActionSheet *photoSourcePicker = [[UIActionSheet alloc] initWithTitle:nil
                                                                       delegate:self cancelButtonTitle:@"Cancel"
                                                         destructiveButtonTitle:nil
                                                              otherButtonTitles:	@"Take Photo",
                                            @"Choose from Library",
                                            nil,
                                            nil];
        
        [photoSourcePicker showInView:self.view];
    }
}

- (void) uploadProgressBarProccess {
    proccess = proccess + 0.001;
    self.progressBarUpload.progress = proccess;
    if (proccess >1) {
        proccess = 0;
        self.progressBarUpload.alpha = 0;
        self.progressBarUpload.progress = 0;
        [timer invalidate];
        timer = nil;
        if (status_upload == YES) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Successful" message:@"You have upload your fashion successful" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            [[MainClass alloc] linkToView:[Menu alloc] CurrentView:self];
        }
        else {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Fail" message:@"You have problem with upload file, please try again !" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
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
    image = imageData;
    UIImage *img = [UIImage imageWithData:imageData];
    
    [[self PhotoFashionView] setImage:img];
   
    if (img != nil) {
        self.btnFashionPhoto.titleLabel.text = @"Upload Now";
        check_image = YES;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event    {
    [self keyboard_hide];
}

- (void)keyboard_hide {
    [self.txtFashionDescription resignFirstResponder];
}

@end
