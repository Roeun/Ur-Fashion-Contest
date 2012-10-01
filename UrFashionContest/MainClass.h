//
//  MainClass.h
//  UrFashionContest
//
//  Created by Apple on 9/14/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ForgetPassword.h"
#import "ViewController.h"
#import "SignUp.h"
#import "Menu.h"
#import "MainPanel.h"
#import "UploadFashion.h"
#import "AccountSetting.h"
#import "ProfilePhoto.h"
#import "BillBoard.h"
#import "JSon.h"
#import "Photo.h"
#import "FashionHistory.h"
#import "FashionDetail.h"


@interface MainClass : NSObject

@property (nonatomic, retain) NSString * host;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * password;

#pragma mark - General tasks
- (void) linkToView:(UIViewController *)viewName CurrentView:(UIViewController *)view;
- (NSString *)dateToString: (NSDate *)urDate;
- (NSString *) pathTmpFile;
- (void) saveToTmpFile:(NSString *)userID userName:(NSString *)userName password:(NSString *)urpassword email:(NSString *)uremail gender:(NSString *)gender phone:(NSString *)phone dateOfBirth:(NSString *)dob  photo:(NSString *)photo;
- (NSArray * ) readTmpFile;
- (BOOL) checkConnection;

#pragma mark - User tasks
- (BOOL) loginAction;

@end
