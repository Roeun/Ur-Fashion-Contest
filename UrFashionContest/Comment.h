//
//  Comment.h
//  UrFashionContest
//
//  Created by Apple on 9/28/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

@property (nonatomic, retain) NSString * cmt;
@property (nonatomic, retain) NSString * pid;
@property (nonatomic, retain) NSString * uid;
@property (nonatomic, retain) NSString * cid;

- (BOOL) postComment;
@end
