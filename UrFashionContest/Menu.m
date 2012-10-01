//
//  Menu.m
//  UrFashionContest
//
//  Created by Apple on 9/19/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import "Menu.h"
#import "MainClass.h"

@interface Menu ()

@end

@implementation Menu
@synthesize MenuView;

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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_all.jpeg"]];
    self.MenuView.backgroundColor  = [UIColor whiteColor];
    
    MainClass * obj = [[MainClass alloc] init];
    NSArray * user_data = [obj readTmpFile];
    self.lblUserStatus.text =[[NSString stringWithFormat:@"Hello, %@", [user_data objectAtIndex:1]] capitalizedString] ;
}

- (void)viewDidUnload
{
    [self setMenuView:nil];
    [self setLblUserStatus:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)btnBack:(id)sender {
    MainClass *obj = [[MainClass alloc] init];
    [obj linkToView:[MainPanel alloc] CurrentView:self];
}

- (IBAction)btnFashion:(id)sender {
    [[MainClass alloc] linkToView:[UploadFashion alloc] CurrentView:self];
}



- (IBAction)btnAccountSetting:(id)sender {
    [[MainClass alloc] linkToView:[AccountSetting alloc] CurrentView:self];
}

- (IBAction)btnProfilePhoto:(id)sender {
    [[MainClass alloc] linkToView:[ProfilePhoto alloc] CurrentView:self];
}

- (IBAction)btnBillBoard:(id)sender {
    [[MainClass alloc] linkToView:[BillBoard alloc] CurrentView:self];
}

- (IBAction)btnFashionHistory:(id)sender {
    [[MainClass alloc] linkToView:[FashionHistory alloc] CurrentView:self];
}


@end
