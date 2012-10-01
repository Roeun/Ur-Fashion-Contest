//
//  ViewController.m
//  UrFashionContest
//
//  Created by Apple on 9/14/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import "ViewController.h"
#import "MainClass.h"

@interface ViewController ()

@end


@implementation ViewController
@synthesize txtEmail;
@synthesize txtPassword;

static double progress;
NSTimer *myTimer;
bool status;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
     self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bgpatter.jpeg"]];
    
}

- (void)viewDidUnload
{
    [self setTxtEmail:nil];
    [self setTxtPassword:nil];
    [self setProgressBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
   
}

- (void) progressBarProcessLogin {
    progress = progress + 0.01;
    self.progressBar.progress = progress;
    if (progress>1) {
        [myTimer invalidate];
        myTimer = nil;
        self.progressBar.progress = 0;
        self.progressBar.alpha = 0;
        [self checklogin:status];
        status = 0;
        progress = 0;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void) checklogin:(BOOL) status {
    
    if ( status == YES) {
        MainClass * obj = [[MainClass alloc] init];
        [obj linkToView:[MainPanel alloc] CurrentView:self];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"alert" message:@"Invalide Information" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }

}

- (IBAction)btnLogin:(id)sender {
    if ([[[MainClass alloc] init] checkConnection] == NO) {
        UIAlertView *msg = [[UIAlertView alloc] initWithTitle:@"Internet Connection" message:@"Internet is not avaible" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [msg show];
    }
    else {
    if ([txtEmail.text isEqualToString:@""] || [txtPassword.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"alert" message:@"Please Fill all the field" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        MainClass * obj = [[MainClass alloc] init];
        obj.password = self.txtPassword.text;
        obj.email = self.txtEmail.text;
        
        status = [obj loginAction];
        
        self.progressBar.alpha = 1;
        myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/100.0
                                                   target:self
                                                 selector:@selector(progressBarProcessLogin)
                                                 userInfo:nil
                                                  repeats:YES];
    }
    }
}


- (IBAction)btnSignUp:(id)sender {
    MainClass *obj = [[MainClass alloc] init];
    [obj linkToView:[SignUp alloc] CurrentView:self];
}

- (IBAction)btnForgetPassword:(id)sender {
    MainClass *obj = [[MainClass alloc] init];
    [obj linkToView:[ForgetPassword alloc] CurrentView:self];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [txtEmail resignFirstResponder];
    [txtPassword resignFirstResponder];
}
@end
