//
//  FeedsViewController.m
//  POLS
//
//  Created by nachi on 24/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyVictoriesViewController.h"


@implementation MyVictoriesViewController
@synthesize listData;
@synthesize feedsData;
@synthesize lbTitle;
@synthesize lbPostedBy;
@synthesize lbOnDate;
@synthesize tableViewCell;
@synthesize viewVictoryDetailController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    NSArray *array = [[NSArray alloc] initWithObjects:@"iPhone",@"iPad",@"Android",@"Nokia",@"BlackBerry", nil];
    self.listData= array;
    
    restConnection =[[RestConnection new]autorelease];
    restConnection.baseURLString=baseURL;
    restConnection.delegate=self;
    
    NSString *urlString = [NSString stringWithFormat:@"feeds.js"];
    [restConnection performRequest:
     [NSURLRequest requestWithURL:
      [NSURL URLWithString:urlString]]];
    [array release];
    NSLog(@"VIcccccccc");
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark RestConnectionDelegate

- (void)willSendRequest:(NSURLRequest *)request
{
	//[activityIndicator startAnimating];
}

- (void)didReceiveResponse:(NSURLResponse *)response
{
	NSLog(@"didReceiveResponse : %@", response);
}

- (void)finishedReceivingData:(NSData *)data
{
	NSLog(@"finishedReceivingData MyVictories: %@", [restConnection stringData]);
    NSString *feedsReponse= [restConnection stringData];
    NSLog(@"MyVictoriesResponse : %@", feedsReponse);
    NSMutableArray *feedsDataArray = [NSMutableArray array];
    feedsDataArray = [FeedsResult parseFeedsData:feedsReponse];
    NSLog(@"%d",[feedsDataArray count]);
    [self storeToDb:feedsDataArray];
    [self readFromDb];
}

-(void) readFromDb
{
    MyVictoriesDbAdapter *feedsDbAdapter = [[MyVictoriesDbAdapter alloc] init];
    feedsData = [feedsDbAdapter getMyVictoriesAll];
}

- (void) storeToDb:(NSMutableArray *)feedsDataArray
{
    NSLog(@"%d",[feedsDataArray count]);
    MyVictoriesDbAdapter *feedsDbAdapter = [[MyVictoriesDbAdapter alloc] init];
    [feedsDbAdapter deleteAll];
    
    for(int i=0;i<[feedsDataArray count];i++)
    {
        FeedsResult *feedsResult = [feedsDataArray objectAtIndex:i];
        [feedsDbAdapter create:feedsResult];
        //        NSLog(@"IDdddddd:   %@",feedsResult.strFeedsId);
        //        NSLog(@"Title:   %@",feedsResult.strFeedsTitle);
        //        NSLog(@"Posted By:   %@",feedsResult.strFeedsPostedBy);
        //        NSLog(@"OnDate:   %@",feedsResult.strFeedsOnDate);
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark Table View Data Source Methods

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // NSLog(@"############%d",feedsData.count);
    MyVictoriesDbAdapter *feedsDbAdapter = [[MyVictoriesDbAdapter alloc] init];
    feedsData = [feedsDbAdapter getMyVictoriesAll];
    return [self.feedsData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62.0;
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *feedsTableIdentifier = @"FeedsTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:feedsTableIdentifier];
    if (cell==nil) {
        [[NSBundle mainBundle] loadNibNamed:@"FeedsTableViewCell" owner:self options:nil];
        cell=tableViewCell;
        self.tableViewCell=nil;
        NSUInteger row = [indexPath row];
        NSLog(@"%d ",row);
        
        // =======================================================
        
        MyVictoriesDbAdapter *feedsDbAdapter = [[MyVictoriesDbAdapter alloc] init];
        feedsData = [feedsDbAdapter getMyVictoriesAll];
        
        FeedsResult *result = [feedsData objectAtIndex: row];
        NSLog(@"Title :::::::- %@",result.strFeedsTitle);
        NSLog(@"Posted by ::::::- %@",result.strFeedsPostedBy);
        
        lbTitle.text = result.strFeedsTitle;
        lbPostedBy.text = result.strFeedsPostedBy;
        // ====================String to Date Conversion ===================
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
        NSDate *postedDate = [dateFormat dateFromString:result.strFeedsOnDate];
        NSLog(@"postedDate....%@",postedDate);
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        
        lbOnDate.text = [dateFormatter stringFromDate:postedDate];
        [dateFormatter release];
        // =======================================================
        
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Cell Selected........");
    // NSLog(@"select .......%@",[feedsData objectAtIndex:[indexPath row]]);
    NSUInteger row = [indexPath row];
    NSLog(@"%d ",row);
    
    // =======================================================
    
    MyVictoriesDbAdapter *feedsDbAdapter = [[MyVictoriesDbAdapter alloc] init];
    feedsData = [feedsDbAdapter getMyVictoriesAll];
    
    FeedsResult *result = [feedsData objectAtIndex: row];
    NSLog(@"Feeds IDddddddd :- %@",result.strFeedsId);
    
    
    viewVictoryDetailController  = [[VictoryDetailController alloc]initWithNibName:@"VictoryDetailController" bundle:nil];
    [self.view addSubview:viewVictoryDetailController.view];
}

- (void) dealloc 
{
    [listData release];
    [feedsData release];
    [restConnection release];
    [super dealloc];
}

@end
