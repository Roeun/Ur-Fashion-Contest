//
//  SignUp.h
//  UrFashionContest
//
//  Created by Apple on 9/19/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUp : UIViewController 
@property (weak, nonatomic) IBOutlet UIScrollView *SignView;
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPwd;

@property (weak, nonatomic) IBOutlet UITextField *txtRePwd;
@property (weak, nonatomic) IBOutlet UITextField *txtGender;
@property (weak, nonatomic) IBOutlet UITextField *txtDd;
@property (weak, nonatomic) IBOutlet UITextField *txtMm;
@property (weak, nonatomic) IBOutlet UITextField *txtYyyy;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;

- (IBAction)btnBack:(id)sender;
- (IBAction)btnSignUp:(id)sender;

@end
