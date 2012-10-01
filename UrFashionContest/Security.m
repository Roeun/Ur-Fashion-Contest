//
//  Security.m
//  UrFashionContest
//
//  Created by Apple on 9/14/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import "Security.h"
#import "AESCrypt.h"

@implementation Security

@synthesize secretKey;

- (id) init  {
    self = [super init];
    if (self) {
        self.secretKey = @"abc";
    }
    return self;
}

- (NSString*) reverseMyString:(NSString*)theString
{
    NSString *result = @"";
    for(int i = [theString length]-1; i>=0; i--) {
        result = [result stringByAppendingFormat:@"%c",[theString characterAtIndex:i]];
    }
    return result;
}

- (NSString *) encryptionData:(NSString *)plainText {
    return [AESCrypt encrypt:plainText password:secretKey];
}

- (NSString *) decryptionData:(NSString *)encryptText    {
    return [AESCrypt decrypt:encryptText password:secretKey];
}

- (NSString *) encodeUrl:(NSString *) url {
    NSString * encoded = [url stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    return [NSURL URLWithString:encoded];
}

- (NSString *) encryptUrl:(NSString *)url {
    
    // reversed string
    NSString * reversed = [self reverseMyString:url];
    
    // add key to string
    NSString * key = @"[]|<>{}";
    NSString * addedKey = @"";
    int j = 0;
    for (int i=0; i<[reversed length]; i++) {
        if ( j >= [key length]) {
            j=0;
        }
        addedKey = [addedKey stringByAppendingFormat:@"%c%c", [reversed characterAtIndex:i], [key characterAtIndex:j]];
        
        j++;
    }
    
    // encode string
    NSString * encodedURL = [self encodeUrl:addedKey];
    return  encodedURL;
    
}


@end    
