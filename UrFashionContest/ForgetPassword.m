//
//  ForgetPassword.m
//  UrFashionContest
//
//  Created by Apple on 9/19/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import "ForgetPassword.h"
#import "MainClass.h"
#import "JSon.h"
#import "Security.h"

@interface ForgetPassword ()

@end

@implementation ForgetPassword
@synthesize ForgetView;
@synthesize txtForgetPassword;

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
    self.ForgetView.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidUnload
{
    [self setForgetView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)btnBack:(id)sender {
    [self keyboard_hide];
    MainClass *obj = [[MainClass alloc] init];
    [obj linkToView:[ViewController alloc] CurrentView:self];
}

- (IBAction)btnResetPassword:(id)sender {
    JSon * objJson = [[JSon alloc] init];
    NSString * email = [[Security alloc] encryptUrl:self.txtForgetPassword.text];
    NSString * fullUrl = [[objJson host] stringByAppendingFormat:@"reset_password.php?email=%@", email];
    NSArray * status = [objJson loadJsonData:fullUrl];
    if ([[[status objectAtIndex:0] objectForKey:@"status"] isEqualToString:@"1"]) {
        UIAlertView * msg = [[UIAlertView alloc] initWithTitle:@"Successful" message:@"You have reset your password successful. Please go to your Email." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [msg show];
    }
    else {
        UIAlertView * msg = [[UIAlertView alloc] initWithTitle:@"Fail" message:@"Please check internet connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [msg show];
    }
    
    [self keyboard_hide];
    [[MainClass alloc] linkToView:[ViewController alloc] CurrentView:self];
}

- (void) sendTomail:(NSString *)urEmail urSubject:(NSString *)subject emailBody:(NSString *)body{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:subject];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:urEmail, nil];
        [mailer setToRecipients:toRecipients];
        
        UIImage *myImage = [UIImage imageNamed:@"fashion.jpeg"];
        NSData *imageData = UIImagePNGRepresentation(myImage);
        [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"UrFashionContest"];
        
        NSString *emailBody = body;
        [mailer setMessageBody:emailBody isHTML:NO];
        
        // only for iPad
        // mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        
        [self presentModalViewController:mailer animated:YES];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"Mail saved: you saved the email message in the Drafts folder");
			break;
		case MFMailComposeResultSent:
			NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send the next time the user connects to email");
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Mail failed: the email message was nog saved or queued, possibly due to an error");
			break;
		default:
			NSLog(@"Mail not sent");
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
}
 


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self keyboard_hide];
}

- (void) keyboard_hide {
    [txtForgetPassword resignFirstResponder];
}

@end
