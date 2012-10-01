//
//  SignUp.m
//  UrFashionContest
//
//  Created by Apple on 9/19/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import "SignUp.h"
#import "MainClass.h"
#import "User.h"

@interface SignUp ()

@end

@implementation SignUp
@synthesize txtPwd;
@synthesize SignView;
@synthesize txtUsername;
@synthesize txtEmail;
@synthesize txtRePwd;
@synthesize txtGender;
@synthesize txtDd;
@synthesize txtMm;
@synthesize txtYyyy;
@synthesize txtPhone;

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
    self.SignView.backgroundColor = [UIColor whiteColor];
    self.SignView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height *1.4);
}

- (void)viewDidUnload
{
    [self setSignView:nil];
    [self setTxtUsername:nil];
    [self setTxtEmail:nil];
    [self setTxtPwd:nil];
    [self setTxtRePwd:nil];
    [self setTxtGender:nil];
    [self setTxtDd:nil];
    [self setTxtMm:nil];
    [self setTxtYyyy:nil];
    [self setTxtPhone:nil];
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

- (IBAction)btnSignUp:(id)sender {
    if ([txtPwd.text isEqualToString:txtRePwd.text]) {
        
        // assign values to properties of class Users
        User * obj_user = [[User alloc] init];
        obj_user.username = txtUsername.text;
        obj_user.password = txtPwd.text;
        obj_user.email = txtEmail.text;
        obj_user.phone = txtPhone.text;
        obj_user.gender = txtGender.text;
        obj_user.dob = [NSString stringWithFormat:@"%@-%@-%@", txtYyyy.text, txtMm.text, txtDd.text];
        obj_user.rdate = [[MainClass alloc] dateToString:[NSDate date]];
    
        BOOL status = [obj_user signUp];
        if (status == YES) {
            UIAlertView * msg = [[UIAlertView alloc] initWithTitle:@"Successful" message:@"You have sign up Ur Fashion Contest Successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,    nil ];
            [msg show];
        }
        else {
            UIAlertView * msg = [[UIAlertView alloc] initWithTitle:@"Fail..." message:@"Please check your information again !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,    nil ];
            [msg show];
        }
    }
    else {
        UIAlertView * msg = [[UIAlertView alloc] initWithTitle:@"Fail..." message:@"Password is not match..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,    nil ];
        [msg show];
    }
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self keyboard_hide];
}

- (void) keyboard_hide {
    [txtEmail resignFirstResponder];
    [txtUsername resignFirstResponder];
    [txtPwd resignFirstResponder];
    [txtRePwd resignFirstResponder];
    [txtGender resignFirstResponder];
    [txtPhone resignFirstResponder];
    [txtDd resignFirstResponder];
    [txtMm resignFirstResponder];
    [txtYyyy resignFirstResponder];
}

@end
