//
//  MainPanel.h
//  UrFashionContest
//
//  Created by Apple on 9/19/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainPanel : UIViewController
<UITableViewDataSource, UITableViewDelegate>
{
    NSInteger sectionIndex;
}
@property (weak, nonatomic) IBOutlet UITableView *tblView;

@property (nonatomic, retain) NSArray *sectionTitle;
@property (nonatomic, retain) NSArray *contents;

- (IBAction)btnLogout:(id)sender;
- (IBAction)btnMenu:(id)sender;
- (IBAction)btnLastest:(id)sender;
- (IBAction)btnTop10:(id)sender;

@end
