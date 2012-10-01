//
//  BillBoard.h
//  UrFashionContest
//
//  Created by Apple on 9/20/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillBoard : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSInteger sectionIndex;
}

@property (nonatomic, retain) NSArray *sectionTitle;
@property (nonatomic, retain) NSArray *contents;
@property (weak, nonatomic) IBOutlet UITableView *tblBillBoard;
- (IBAction)btnBack:(id)sender;
- (NSArray *) getBillBoard;
@end
