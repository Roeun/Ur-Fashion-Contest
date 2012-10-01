//
//  Photo.h
//  UrFashionContest
//
//  Created by Apple on 9/21/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//


@interface Photo : NSObject

@property (nonatomic, retain) NSString * pname;
@property (nonatomic, retain) NSString * pdes;
@property (nonatomic, retain) NSString * postDate;
@property (nonatomic, retain) NSString * uid;
@property (nonatomic, retain) NSString * pdata;

- (BOOL) uploadFashionPhoto;
//- (BOOL) uploadProfilePhoto;
- (BOOL) moveUploadFile:(NSData *) imageData NameofImage:(NSString *)imageName;
- (NSArray *) getFashionDetailDataPID: (NSString *) urPID;
- (NSArray *) getCommentDetailPID: (NSString *)urPID ;
@end
