//
//  Security.h
//  UrFashionContest
//
//  Created by Apple on 9/14/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AESCrypt.h"

@interface Security : NSObject

@property (nonatomic, retain) NSString * secretKey;

- (NSString*) reverseMyString:(NSString*)theString;
- (NSString *) encryptionData:(NSString *)plainText;
- (NSString *) decryptionData:(NSString *)encryptText;
- (NSString *) encodeUrl:(NSString *) url;

// * encrypt URL
- (NSString *) encryptUrl:(NSString *) url;
@end
