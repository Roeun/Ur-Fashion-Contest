//
//  ViewController.h
//  UrFashionContest
//
//  Created by Apple on 9/14/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;

- (IBAction)btnLogin:(id)sender;
- (IBAction)btnSignUp:(id)sender;
- (IBAction)btnForgetPassword:(id)sender;

@end
