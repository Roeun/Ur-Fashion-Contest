//
//  ForgetPassword.h
//  UrFashionContest
//
//  Created by Apple on 9/19/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ForgetPassword : UIViewController <MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *ForgetView;
- (IBAction)btnBack:(id)sender;
- (IBAction)btnResetPassword:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtForgetPassword;
@end
