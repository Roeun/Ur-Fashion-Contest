//
//  User.m
//  UrFashionContest
//
//  Created by Apple on 9/19/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import "User.h"
#import "JSon.h"
#import "Security.h"

@implementation User

- (BOOL) signUp {
    
    NSString * fields = @"uname,pwd,email,gender,rdate,dob,phone";
    NSString * values = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@", self.username, self.password, self.email, self.gender, self.rdate,self.dob, self.phone];
    
    Security * obj = [[Security alloc] init];
    NSString * a = [obj encryptUrl:@"insert"];
    NSString * f = [obj encryptUrl:fields];
    NSString * v = [obj encryptUrl:values];
    NSString * t = [obj encryptUrl:@"tblusers"];
    
    JSon *Obj_json = [[JSon alloc] init];
    NSArray * data = [Obj_json loadJsonData:[Obj_json.host stringByAppendingFormat:@"query.php?a=%@&f=%@&v=%@&t=%@", a, f, v, t]];
    
    NSString * status = [[data objectAtIndex:0] objectForKey:@"status"];
    
    if ( [status isEqualToString:@"1"]) {
        return YES;
    }
    else {
        return NO;
    }
}

- (BOOL) saveAccountSetting: (NSString *) UserId{
    
    NSString * fields = @"uname,pwd,email,gender,rdate,dob,phone";
    NSString * values = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@", self.username, self.password, self.email, self.gender, self.rdate,self.dob, self.phone];
    
    Security * obj = [[Security alloc] init];
    NSString * a = [obj encryptUrl:@"update"];
    NSString * f = [obj encryptUrl:fields];
    NSString * v = [obj encryptUrl:values];
    NSString * t = [obj encryptUrl:@"tblusers"];
    NSString * c = [obj encryptUrl:[NSString stringWithFormat:@"where uid=%@", UserId]];
    
    JSon *Obj_json = [[JSon alloc] init];
    NSArray * data = [Obj_json loadJsonData:[Obj_json.host stringByAppendingFormat:@"query.php?a=%@&f=%@&v=%@&t=%@&c=%@", a, f, v, t, c]];
    
    NSString * status = [[data objectAtIndex:0] objectForKey:@"status"];
    
    if ( [status isEqualToString:@"1"]) {
        return YES;
    }
    else {
        return NO;
    }
}

- (BOOL) saveProfilePhotoUserID : (NSString *) UserId{
    
    NSString * fields = @"picture";
    NSString * values = [NSString stringWithFormat:@"%@", self.picture];
    
    Security * obj = [[Security alloc] init];
    NSString * a = [obj encryptUrl:@"update"];
    NSString * f = [obj encryptUrl:fields];
    NSString * v = [obj encryptUrl:values];
    NSString * t = [obj encryptUrl:@"tblusers"];
    NSString * c = [obj encryptUrl:[NSString stringWithFormat:@"where uid=%@", UserId]];

    
    JSon *Obj_json = [[JSon alloc] init];
    NSArray * data = [Obj_json loadJsonData:[Obj_json.host stringByAppendingFormat:@"query.php?a=%@&f=%@&v=%@&t=%@&c=%@", a, f, v, t, c]];
    
    NSString * status = [[data objectAtIndex:0] objectForKey:@"status"];
    
    if ( [status isEqualToString:@"1"]) {
        return YES;
    }
    else {
        return NO;
    }
}
@end
