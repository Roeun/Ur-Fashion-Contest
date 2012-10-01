//
//  FashionDetail.h
//  UrFashionContest
//
//  Created by Apple on 9/27/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainClass.h"

@interface FashionDetail : UIViewController <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *FashionDetailView;
@property (weak, nonatomic) IBOutlet UILabel *lblPostDate;
@property (weak, nonatomic) IBOutlet UILabel *lbllike;
@property (weak, nonatomic) IBOutlet UILabel *lblcmt;
@property (weak, nonatomic) IBOutlet UIImageView *FashionDetailPhotoView;
@property (retain ,nonatomic) NSString * PID;

- (IBAction)btnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtCmt;
@property (weak, nonatomic) IBOutlet UILabel *lblDetailComment;
- (IBAction)btnPostComment:(id)sender;
- (IBAction)btnLike:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnLike;

@end
