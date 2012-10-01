//
//  JSon.h
//  UrFashionContest
//
//  Created by Apple on 9/19/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSon : NSObject

@property (nonatomic, retain) NSString * host;

- (NSArray *) loadJsonData:(NSString *)fullUrl;
@end
