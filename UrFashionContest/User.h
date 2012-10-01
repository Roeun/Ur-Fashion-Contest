//
//  User.h
//  UrFashionContest
//
//  Created by Apple on 9/19/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * dob;
@property (nonatomic, retain) NSString * rdate;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * picture;

- (BOOL) signUp;

- (BOOL) saveAccountSetting: (NSString *) UserId;

 - (BOOL) saveProfilePhotoUserID : (NSString *) UserId;
@end
