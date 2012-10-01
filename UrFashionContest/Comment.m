//
//  Comment.m
//  UrFashionContest
//
//  Created by Apple on 9/28/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import "Comment.h"
#import "JSon.h"
#import "Security.h"

@implementation Comment

@synthesize cmt;
@synthesize pid;
@synthesize uid;
@synthesize cid;

-(BOOL) postComment {
    JSon *objJson = [[JSon alloc] init];
    NSString * host = [objJson host];
    
    Security *objSecurity = [Security alloc];
    cmt = [objSecurity encryptUrl:cmt];
    pid = [objSecurity encryptUrl:pid];
    uid = [objSecurity encryptUrl:uid];
    
    NSString * fullUrl = [host stringByAppendingFormat:@"post_comment.php?cmt=%@&pid=%@&uid=%@&", cmt, pid, uid];
    
    NSArray * status = [objJson loadJsonData:fullUrl];
    if ([[status valueForKey:@"status"] isEqualToString:@"1"]) {
        return YES;
    }
    return NO;
}

@end
