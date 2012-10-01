//
//  FashionHistory.h
//  UrFashionContest
//
//  Created by Apple on 9/25/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FashionHistory : UIViewController
<UITableViewDataSource, UITableViewDelegate>
{
    NSInteger sectionIndex;
}

@property (nonatomic, retain) NSArray *sectionTitle;
@property (nonatomic, retain) NSArray *contents;
@property (weak, nonatomic) IBOutlet UITableView *tblFashionHistory;

- (IBAction)btnBack:(id)sender;
- (NSArray *) getFashionHistory ;
@end
