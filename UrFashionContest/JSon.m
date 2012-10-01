//
//  JSon.m
//  UrFashionContest
//
//  Created by Apple on 9/19/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import "JSon.h"

@implementation JSon

- (id)init {
    self.host = @"http://ruc_chhorn.ruptest.com/ufc/";
    return self;
}

// load Json data by parse full url
- (NSArray *) loadJsonData: (NSString *)fullUrl {
    NSString *urlString = [NSString stringWithString:fullUrl];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSError *error;
    
    NSArray *json = (NSArray*)[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    return json;
}

@end
