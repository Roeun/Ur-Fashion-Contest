//
//  MainClass.m
//  UrFashionContest
//
//  Created by Apple on 9/14/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import "MainClass.h"
#import "Security.h"
#import "Reachability.h"


@implementation MainClass

@synthesize host;
@synthesize email;
@synthesize password;

- (id)init {
    self.host = [[[JSon alloc] init] host];
    return self;
}

#pragma mark - General tasks
- (void) linkToView:(UIViewController *)viewName CurrentView:(UIViewController *)view{
    viewName.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [view presentModalViewController:viewName animated:YES];
}



- (NSString *)dateToString:(NSDate *)urDate {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:urDate];
    return dateString;
}

- (NSString *) pathTmpFile
{
	NSArray *path =
	NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
	return [[path objectAtIndex:0] stringByAppendingPathComponent:@"tmp.plist"];
    
}

- (void) saveToTmpFile:(NSString *)userID userName:(NSString *)userName password:(NSString *)urpassword email:(NSString *)uremail gender:(NSString *)gender phone:(NSString *)phone dateOfBirth:(NSString *)dob photo:(NSString *)photo{
    NSArray *values = [[NSArray alloc] initWithObjects:userID,userName, urpassword, uremail, gender, phone, dob, photo, nil];
	[values writeToFile:[self pathTmpFile]  atomically:YES];
}

- (NSArray *)readTmpFile {
    
    NSString *myPath = [self pathTmpFile];
    
	BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:myPath];
    
	if (fileExists)
	{
		NSArray *values = [[NSArray alloc] initWithContentsOfFile:myPath];
		return values;
	}
    return  nil;
}

- (BOOL) checkConnection {
    NSString * urlCheck = [host stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    urlCheck = [urlCheck stringByReplacingOccurrencesOfString:@"/ufc/" withString:@""];
    if ([[Reachability reachabilityWithHostName:urlCheck] currentReachabilityStatus] == ReachableViaWiFi) {
        return YES;
    } else if ([[Reachability reachabilityWithHostName:urlCheck] currentReachabilityStatus] == ReachableViaWWAN) {
        return YES;
    } else if ([[Reachability reachabilityWithHostName:urlCheck] currentReachabilityStatus] == NotReachable) {
        return NO;
    }
    return NO;
}

#pragma mark - User tasks
- (BOOL) loginAction{
    
    Security *secure = [[Security alloc] init];
    
    NSArray * data = [[JSon alloc] loadJsonData:[NSString stringWithFormat:@"%@login.php?email=%@&password=%@", self.host, [secure encryptUrl: email],[secure encryptUrl:password]]];
   
    NSString * status = [[data objectAtIndex:0] objectForKey:@"uid"];
       
    if (![status isEqualToString:@"0"]) {
        NSString * uname = [[data valueForKey:@"uname"] objectAtIndex:0];
        NSString * pwd = [[data valueForKey:@"pwd"] objectAtIndex:0];
        NSString * uremail = [[data valueForKey:@"email"] objectAtIndex:0];
        NSString * gender = [[data valueForKey:@"gender"] objectAtIndex:0];
        NSString * phone = [[data valueForKey:@"phone"] objectAtIndex:0];
        NSString * dob = [[data valueForKey:@"dob"] objectAtIndex:0];
        NSString * photo = [[data valueForKey:@"picture"] objectAtIndex:0];
        [self saveToTmpFile:status  userName:uname password:pwd email:uremail gender:gender phone:phone dateOfBirth:dob photo:photo];
        return YES;
    }
    else {
        return NO;
    }
    
    /*
    
    NSString *urlString = [NSString stringWithFormat:@"http://localhost/upc/login.php?email=%@&password=%@",email, password];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSError *error;
    
    NSDictionary *json = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    
    NSLog(@"%@", [json objectForKey:@"login"]);
     
     */
    
    /*
    NSString *strURL = [NSString stringWithFormat:@"http://localhost/upc/login.php?email=%@&password=%@",email, password];
    
    // to execute php code
    NSData *dataURL = [NSData dataWithContentsOfURL:[NSURL URLWithString:strURL]];
    
    // to receive the returend value
    NSString *strResult = [[NSString alloc] initWithData:dataURL encoding:NSUTF8StringEncoding];
    
    // check is correct user or not
    if ([strResult isEqualToString:@"1"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
     */
}


@end
