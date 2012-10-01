//
//  MainPanel.m
//  UrFashionContest
//
//  Created by Apple on 9/19/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//


#import "MainClass.h"
#import "AppDelegate.h"


@interface MainPanel ()

@end

@implementation MainPanel

@synthesize sectionTitle;
@synthesize contents;

#pragma mark - general tasks
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
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg_all.jpeg"]];
    
    
    sectionTitle = [[NSArray alloc] initWithObjects:@"Lastest Fashion", @"Top 10 Fashion this month", nil ];
    sectionIndex = 0;
    [self topTenFashion];
}

- (void)viewDidUnload
{
    [self setTblView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    tableView.backgroundColor = [UIColor whiteColor];
    return [contents count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    UIButton *myAccessoryButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [myAccessoryButton setBackgroundColor:[UIColor clearColor]];
    [myAccessoryButton setImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];
    [cell setAccessoryView:myAccessoryButton];
    
    cell.textLabel.font =[UIFont systemFontOfSize:13];
    cell.textLabel.text = [NSString stringWithFormat:@"Post date: %@", [[contents objectAtIndex:[indexPath row]] objectForKey:@"postdate"]];
    
    cell.detailTextLabel.font =[UIFont systemFontOfSize:10];
    NSString * like = [[contents objectAtIndex:[indexPath row]]objectForKey:@"likecount"];
    NSString * cmt = [[contents objectAtIndex:[indexPath row]]objectForKey:@"commentcount"];
    cell.detailTextLabel.text =[NSString stringWithFormat:@"%@ likes and %@ comments", like, cmt];
    
    
    if (sectionIndex ==1) {
        NSString * totalscore = [[contents objectAtIndex:[indexPath row]]objectForKey:@"totalscore"];
        cell.detailTextLabel.text =[NSString stringWithFormat:@"%@ likes and %@ comments; Totoal score: %@", like, cmt, totalscore];
    }
    
    
    NSString * imageUrl = [[[JSon alloc] init] host] ;
    imageUrl = [imageUrl stringByAppendingFormat:@"upload/%@", [[contents objectAtIndex:[indexPath row]] objectForKey:@"pname"]];
    NSData * image = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imageUrl]];
    cell.imageView.image = [UIImage imageWithData:image];
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section  {
    return [sectionTitle objectAtIndex:sectionIndex];
}

// select row event
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * pid = [[contents objectAtIndex:[indexPath row]] objectForKey:@"pid"];
    AppDelegate *objAppDelegate = [[UIApplication sharedApplication] delegate];
    objAppDelegate.tmpPID = pid;
    [[MainClass alloc] linkToView:[FashionDetail alloc] CurrentView:self];
    
}


#pragma mark - action of button
- (IBAction)btnLogout:(id)sender {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Log out" message:@"Do you want to log out?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        
        MainClass *obj = [[MainClass alloc] init];
        [obj linkToView:[ViewController alloc] CurrentView:self];
    }
    
}
- (IBAction)btnMenu:(id)sender {
    MainClass *obj = [[MainClass alloc] init];
    [obj linkToView:[Menu alloc] CurrentView:self];
}

- (IBAction)btnLastest:(id)sender {
    [self.tblView reloadData];
    sectionIndex = 1;
    [self topTenFashion];
}

- (IBAction)btnTop10:(id)sender {
    [self.tblView reloadData];
    sectionIndex = 0;
    [self lastestFashion];
}

- (void) lastestFashion {
    JSon *obj = [[JSon alloc]init];
    NSString *Url = [obj host];
    Url = [Url stringByAppendingString:@"lastest_fashion.php"];
    NSArray * data = [obj loadJsonData:Url];
    contents = data;
}

- (void) topTenFashion {
    JSon *obj = [[JSon alloc]init];
    NSString *Url = [obj host];
    Url = [Url stringByAppendingString:@"top10fashion.php"];
    NSArray * data = [obj loadJsonData:Url];
    contents = data;
}


@end
