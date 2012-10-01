//
//  Like.m
//  UrFashionContest
//
//  Created by Apple on 9/28/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import "Like.h"
#import "JSon.h"
#import "Security.h"

@implementation Like

@synthesize pid;
@synthesize uid;
@synthesize cid;

- (void) setLike {
    JSon *objJson = [[JSon alloc] init];
    NSString * host = [objJson host];
    
    Security *objSecurity = [Security alloc];
    pid = [objSecurity encryptUrl:pid];
    uid = [objSecurity encryptUrl:uid];
    
    NSString * fullUrl = [host stringByAppendingFormat:@"like.php?&pid=%@&uid=%@&", pid, uid];
    
    [objJson loadJsonData:fullUrl];
    
}

- (BOOL) isLike{
    JSon *objJson = [[JSon alloc] init];
    NSString * host = [objJson host];
    
    Security *objSecurity = [Security alloc];
    pid = [objSecurity encryptUrl:pid];
    uid = [objSecurity encryptUrl:uid];
    NSString * isLike = [objSecurity encryptUrl:@"check"];
    
    NSString * fullUrl = [host stringByAppendingFormat:@"like.php?islike=%@&pid=%@&uid=%@&", isLike,pid, uid];
    
    NSArray * status = [objJson loadJsonData:fullUrl];
    if ([[status valueForKey:@"status"] isEqualToString:@"1"]) {
        return YES;
    }
    return  NO;
}


@end
