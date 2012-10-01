//
//  Photo.m
//  UrFashionContest
//
//  Created by Apple on 9/21/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import "Photo.h"
#import "JSon.h"
#import "Security.h"

@implementation Photo

@synthesize pname;
@synthesize pdes;
@synthesize postDate;
@synthesize uid;
@synthesize pdata;

-(BOOL) uploadFashionPhoto {
    NSString * fields = @"pname,pdes,postdate,uid,pdata";
    NSString * values = [NSString stringWithFormat:@"%@,%@,%@,%@,%@", self.pname, self.pdes, self.postDate, self.uid, self.pdata];
    
    Security * obj = [[Security alloc] init];
    NSString * a = [obj encryptUrl:@"insert"];
    NSString * f = [obj encryptUrl:fields];
    NSString * v = [obj encryptUrl:values];
    NSString * t = [obj encryptUrl:@"tblphotos"];
    
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

- (BOOL) moveUploadFile:(NSData *)imageData NameofImage:(NSString *)imageName{
    NSString *urlString = [NSString stringWithFormat: @"%@/upload.php", [[[JSon alloc] init ]host]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSString * contentDisposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@\"\r\n", imageName];
    
    [body appendData:[contentDisposition dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    if ([returnString isEqualToString:@"1"]) {
        return YES;
    }
    return NO;
}

- (NSArray *) getFashionDetailDataPID: (NSString *) urPID{
    Security *objSecurity = [[Security alloc] init];
    JSon *objJson = [[JSon alloc] init];
    NSString * host = [objJson host];
    NSString * fullUrl = [host stringByAppendingFormat:@"fashion_detail.php?pid=%@", [objSecurity encryptUrl:urPID] ];
    NSArray * data = [objJson loadJsonData:fullUrl];
    
    return data;
}

- (NSArray *) getCommentDetailPID:(NSString *)urPID {
    Security *objSecurity = [[Security alloc] init];
    JSon *objJson = [[JSon alloc] init];
    NSString * host = [objJson host];
    NSString * fullUrl = [host stringByAppendingFormat:@"comment_detail.php?pid=%@", [objSecurity encryptUrl:urPID] ];
    NSArray * data = [objJson loadJsonData:fullUrl];
    return data;
}

@end
