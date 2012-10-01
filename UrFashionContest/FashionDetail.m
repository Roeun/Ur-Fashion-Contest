//
//  FashionDetail.m
//  UrFashionContest
//
//  Created by Apple on 9/27/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import "FashionDetail.h"
#import "MainClass.h"
#import "AppDelegate.h"
#import "Comment.h"
#import "Like.h"

@interface FashionDetail ()

@end

@implementation FashionDetail
@synthesize lblPostDate;
@synthesize lbllike;
@synthesize lblcmt;
@synthesize FashionDetailPhotoView;
@synthesize FashionDetailView;
@synthesize PID;
@synthesize txtCmt;
@synthesize lblDetailComment;
@synthesize btnLike;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    AppDelegate *objAppDelegate = [[UIApplication sharedApplication] delegate];
    PID = objAppDelegate.tmpPID;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_all.jpeg"]];
    self.FashionDetailView.backgroundColor = [UIColor whiteColor];
    
    
    // fashion detail
    NSArray * data = [[Photo alloc] getFashionDetailDataPID:PID];
    
    lblPostDate.text = [lblPostDate.text stringByAppendingString: [[data  objectAtIndex:0] objectForKey:@"postdate"]] ;
    lbllike.text = [lbllike.text stringByAppendingString: [[data  objectAtIndex:0] objectForKey:@"likecount"]] ;
    lblcmt.text = [lblcmt.text stringByAppendingString: [[data  objectAtIndex:0] objectForKey:@"commentcount"]] ;
    NSString * imageUrl = [[[[JSon alloc]init] host] stringByAppendingFormat:@"upload/%@", [[data objectAtIndex:0] objectForKey:@"pname"]];
    NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
    FashionDetailPhotoView.image = [UIImage imageWithData:imageData];
    
    [self getCommentDetail];
    [self checkLike];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setFashionDetailView:nil];
    [self setLblPostDate:nil];
    [self setLbllike:nil];
    [self setLblcmt:nil];
    [self setFashionDetailPhotoView:nil];
    [self setTxtCmt:nil];
    [self setLblDetailComment:nil];
    [self setBtnLike:nil];
    [super viewDidUnload];
}

- (IBAction)btnBack:(id)sender {
    [self keyboard_hide];
    AppDelegate *objAppDelegate = [[UIApplication sharedApplication] delegate];
    PID = objAppDelegate.tmpPID;
    if ([objAppDelegate.tmpPage isEqualToString:@"history"]) {
        objAppDelegate.tmpPage = @"";
        [[MainClass alloc] linkToView:[Menu alloc] CurrentView:self];
    }
    else if ([objAppDelegate.tmpPage isEqualToString:@"billboard"]) {
        objAppDelegate.tmpPage = @"";
        [[MainClass alloc] linkToView:[BillBoard alloc] CurrentView:self];
    }
    else {
        [[MainClass alloc] linkToView:[MainPanel alloc] CurrentView:self];
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event    {
    [self keyboard_hide];
}

- (void) keyboard_hide{
    [txtCmt resignFirstResponder];
}


- (void) getCommentDetail {
    
    lblDetailComment.text = @"";
    // comment detail
    NSArray *cmtData =  [[Photo alloc] getCommentDetailPID:PID];
    for (int i=0; i<[cmtData count]; i++) {
        lblDetailComment.text = [lblDetailComment.text stringByAppendingFormat:@"\b%@: %@ \n\n",[[[cmtData objectAtIndex:i] objectForKey:@"uname"] capitalizedString] , [[cmtData objectAtIndex:i] objectForKey:@"cmt"] ];
    }
    [lblDetailComment sizeToFit];
}

- (void) postUrComment:(NSString *)cmt {
    Comment * objComment = [Comment alloc];
    objComment.cmt = cmt;
    objComment.pid = PID;
    NSArray * user_data = [[MainClass  alloc] readTmpFile];
    objComment.uid = [user_data objectAtIndex:0];
    BOOL status = [objComment postComment];
    if (status == YES) {
        [self getCommentDetail];
    }
    else {
        UIAlertView * msg = [[UIAlertView alloc] initWithTitle:@"Fail" message:@"You have problem with post comment. Try again..." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [msg show];
    }
}

- (IBAction)btnPostComment:(id)sender {
    [self postUrComment:txtCmt.text];
    [self keyboard_hide];
    txtCmt.text = @"";
}

- (IBAction)btnLike:(id)sender {
    Like *objLike = [Like alloc];
    objLike.pid = PID;
    objLike.uid = [[[MainClass alloc] readTmpFile] objectAtIndex:0];
    [objLike setLike];
    [self checkLike];
}

- (void) checkLike {
    Like *objLike = [Like alloc];
    objLike.pid = PID;
    objLike.uid = [[[MainClass alloc] readTmpFile] objectAtIndex:0];
    BOOL status = [objLike isLike];
    if (status == YES) {
        [btnLike setImage:[UIImage imageNamed:@"like_ready.png"] forState:UIControlStateNormal];
    }
    else {
        [btnLike setImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
    }
}


@end
