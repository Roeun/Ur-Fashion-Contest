//
//  AccountSetting.m
//  UrFashionContest
//
//  Created by Apple on 9/20/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import "AccountSetting.h"
#import "MainClass.h"
#import "User.h"
#import "Security.h"

@interface AccountSetting ()

@end

@implementation AccountSetting


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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_all.jpeg"]] ;
    self.AccountSettingView.backgroundColor = [UIColor whiteColor];
    self.AccountSettingView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height *2);
    
    // load user profile
    NSArray * user_data = [[MainClass alloc] readTmpFile];
    self.txtUsername.text = [user_data objectAtIndex:1];
    self.txtPassword.text = [user_data objectAtIndex:2];
    self.txtRePassword.text = [user_data objectAtIndex:2];
    self.txtEmail.text = [user_data objectAtIndex:3];
    self.txtGender.text = [user_data objectAtIndex:4];
    self.txtPhone.text = [user_data objectAtIndex:5];
    NSArray * dob = [[user_data objectAtIndex:6] componentsSeparatedByString:@"-"];
    self.txtYyyy.text = [dob objectAtIndex:0];
    self.txtMm.text = [dob objectAtIndex:1];
    self.txtDd.text = [dob objectAtIndex:2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setAccountSettingView:nil];
    [self setTxtUsername:nil];
    [self setTxtEmail:nil];
    [self setTxtPassword:nil];
    [self setTxtRePassword:nil];
    [self setTxtGender:nil];
    [self setTxtDd:nil];
    [self setTxtMm:nil];
    [self setTxtYyyy:nil];
    [self setTxtPhone:nil];
    [super viewDidUnload];
}
- (IBAction)btnBack:(id)sender {
    [self keyboard_hide];
    [[MainClass alloc] linkToView:[Menu alloc] CurrentView:self];
}
- (IBAction)btnSave:(id)sender {
    [self keyboard_hide];
    // assign values to properties of class Users
    if ([self.txtPassword.text isEqualToString:self.txtRePassword.text]) {
        User * obj_user = [[User alloc] init];
        obj_user.username = self.txtUsername.text;
        obj_user.password = self.txtPassword.text;
        obj_user.email = self.txtEmail.text;
        obj_user.phone = self.txtPhone.text;
        obj_user.gender = self.txtGender.text;
        obj_user.dob = [NSString stringWithFormat:@"%@-%@-%@", self.txtYyyy.text, self.txtMm.text, self.txtDd.text];
        obj_user.rdate = [[MainClass alloc] dateToString:[NSDate date]];
    
        NSArray * user_data = [[MainClass alloc] readTmpFile];
        
        BOOL status = [obj_user saveAccountSetting:[user_data objectAtIndex:0]];
        if (status == YES) {
            UIAlertView * msg = [[UIAlertView alloc] initWithTitle:@"Successful" message:@"You have sign up Ur Fashion Contest Successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,    nil ];
            [msg show];
        }
        else {
            UIAlertView * msg = [[UIAlertView alloc] initWithTitle:@"Fail..." message:@"Please check your information again !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,    nil ];
            [msg show];
        }
    }else {
        UIAlertView * msg = [[UIAlertView alloc] initWithTitle:@"Fail..." message:@"Password is not match !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,    nil ];
        [msg show];
    }
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self keyboard_hide];
}

- (void) keyboard_hide {
    [self.txtEmail resignFirstResponder];
    [self.txtUsername resignFirstResponder];
    [self.txtPassword resignFirstResponder];
    [self.txtRePassword resignFirstResponder];
    [self.txtGender resignFirstResponder];
    [self.txtPhone resignFirstResponder];
    [self.txtDd resignFirstResponder];
    [self.txtMm resignFirstResponder];
    [self.txtYyyy resignFirstResponder];
}
@end
