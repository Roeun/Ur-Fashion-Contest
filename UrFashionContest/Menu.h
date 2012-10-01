//
//  Menu.h
//  UrFashionContest
//
//  Created by Apple on 9/19/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Menu : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *MenuView;
@property (weak, nonatomic) IBOutlet UILabel *lblUserStatus;
- (IBAction)btnBack:(id)sender;
- (IBAction)btnFashion:(id)sender;
- (IBAction)btnAccountSetting:(id)sender;
- (IBAction)btnProfilePhoto:(id)sender;
- (IBAction)btnBillBoard:(id)sender;
- (IBAction)btnFashionHistory:(id)sender;


@end
