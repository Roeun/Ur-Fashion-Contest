//
//  FashionHistory.m
//  UrFashionContest
//
//  Created by Apple on 9/25/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import "FashionHistory.h"
#import "MainClass.h"
#import "JSon.h"
#import "Security.h"
#import "AppDelegate.h"

@interface FashionHistory ()

@end

@implementation FashionHistory
@synthesize sectionTitle;
@synthesize contents;

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
    self.tblFashionHistory.backgroundColor = [UIColor whiteColor];
    
    sectionTitle = [[NSArray alloc] initWithObjects:@"Fashions have been competed...", nil ];
    sectionIndex = 0;
    //contents = [[NSArray alloc] initWithObjects:@"test1", @"test2", @"test3", @"test4", nil ];
    contents = [self getFashionHistory];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTblFashionHistory:nil];
    [super viewDidUnload];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    tableView.backgroundColor = [UIColor whiteColor];
    //return [contents count];
    return [contents count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.text = [@"Post Date: " stringByAppendingString: [[contents objectAtIndex:[indexPath row]] objectForKey:@"postdate"]];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
    NSString * like = [[contents objectAtIndex:[indexPath row]]objectForKey:@"likecount"];
    NSString * cmt = [[contents objectAtIndex:[indexPath row]]objectForKey:@"commentcount"];
    cell.detailTextLabel.text = [NSString stringWithFormat: @"%@ likes and %@ comments", like, cmt] ;
    
    UIButton *myAccessoryButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [myAccessoryButton setBackgroundColor:[UIColor clearColor]];
    [myAccessoryButton setImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];
    [cell setAccessoryView:myAccessoryButton];
    
    // set image to table view
    JSon * obj = [[JSon alloc] init];
    NSString * imageName = [[obj host] stringByAppendingFormat:@"upload/%@", [[contents objectAtIndex:[indexPath row]] objectForKey:@"pname"]];
    NSData * imageData = [NSData dataWithContentsOfURL:[NSURL
                                          URLWithString:imageName]];
    UIImage * image = [UIImage imageWithData:imageData];
    cell.imageView.image = image;
    
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section  {
    return [sectionTitle objectAtIndex:sectionIndex];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * pid = [[contents objectAtIndex:[indexPath row]] objectForKey:@"pid"];
    AppDelegate *objAppDelegate = [[UIApplication sharedApplication] delegate];
    objAppDelegate.tmpPID = pid;
    objAppDelegate.tmpPage = @"history";
    [[MainClass alloc] linkToView:[FashionDetail alloc] CurrentView:self];
}

- (IBAction)btnBack:(id)sender {
    [[MainClass alloc] linkToView:[Menu alloc] CurrentView:self];
}

- (NSArray *) getFashionHistory {
    JSon * obj = [[JSon alloc] init];
    Security *security = [[Security alloc] init];
    NSArray * user_data = [[MainClass alloc] readTmpFile];
    NSString * uid = [security encryptUrl:[user_data objectAtIndex:0]];
    NSArray * data = [obj loadJsonData:[NSString stringWithFormat:@"%@history.php?uid=%@", obj.host, uid]];
    return data;
}
@end
