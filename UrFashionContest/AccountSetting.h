//
//  AccountSetting.h
//  UrFashionContest
//
//  Created by Apple on 9/20/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountSetting : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *AccountSettingView;
- (IBAction)btnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtRePassword;
@property (weak, nonatomic) IBOutlet UITextField *txtGender;
@property (weak, nonatomic) IBOutlet UITextField *txtDd;
@property (weak, nonatomic) IBOutlet UITextField *txtMm;
@property (weak, nonatomic) IBOutlet UITextField *txtYyyy;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
- (IBAction)btnSave:(id)sender;

@end
