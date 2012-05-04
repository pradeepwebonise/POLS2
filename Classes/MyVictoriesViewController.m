//
//  FeedsViewController.m
//  POLS
//
//  Created by nachi on 24/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyVictoriesViewController.h"

@implementation MyVictoriesViewController
@synthesize myVictoriesData;
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
    restConnection =[[RestConnection new]autorelease];
    restConnection.baseURLString=baseURL;
    restConnection.delegate=self;
    NSString *authToken = @"9819349370015737382199895";
   
//    int pageNo=1;
//    NSString *postData = [[NSString alloc] initWithFormat:@"AUTH_KEY=%@&PAGE_NO=%i",authToken,pageNo];
//    NSString *urlString = [NSString stringWithFormat:@"my_victories.js"];
//    [restConnection performRequestGET:[NSURLRequest requestWithURL:
//     [NSURL URLWithString:urlString]]:postData];
//    
    
    int pageNo=1;
    NSURL *url = [NSURL URLWithString:@""];
//    NSString *postData = [[NSString alloc] initWithFormat:@"AUTH_KEY=%@&PAGE_NO=%i",authToken,pageNo];
     NSString *postData = [[NSString alloc] initWithFormat:@"AUTH_KEY=%@&PAGE_NO=%i",authToken,pageNo];
    [restConnection performRequest:[NSURLRequest requestWithURL:url]];
    
    
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
    NSMutableArray *myVictoriesDataArray = [NSMutableArray array];
    myVictoriesDataArray = [FeedsResult parseFeedsData:feedsReponse];
    NSLog(@"%d",[myVictoriesDataArray count]);
    [self storeToDb:myVictoriesDataArray];
    [self readFromDb];
}

-(void) readFromDb
{
    MyVictoriesDbAdapter *myVictoriesDbAdapter = [[MyVictoriesDbAdapter alloc] init];
    myVictoriesData = [myVictoriesDbAdapter getMyVictoriesAll];
}

- (void) storeToDb:(NSMutableArray *)myVictoriesDataArray
{
    NSLog(@"%d",[myVictoriesDataArray count]);
    MyVictoriesDbAdapter *myVictoriesDbAdapter = [[MyVictoriesDbAdapter alloc] init];
    [myVictoriesDbAdapter deleteAll];
    
    for(int i=0;i<[myVictoriesDataArray count];i++)
    {
        FeedsResult *feedsResult = [myVictoriesDataArray objectAtIndex:i];
        [myVictoriesDbAdapter create:feedsResult];
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
    MyVictoriesDbAdapter *myVictoriesDbAdapter = [[MyVictoriesDbAdapter alloc] init];
    myVictoriesData = [myVictoriesDbAdapter getMyVictoriesAll];
    return [self.myVictoriesData count];
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
        myVictoriesData = [feedsDbAdapter getMyVictoriesAll];
        
        FeedsResult *result = [myVictoriesData objectAtIndex: row];
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
    
    MyVictoriesDbAdapter *myVictoriesDbAdapter = [[MyVictoriesDbAdapter alloc] init];
    myVictoriesData = [myVictoriesDbAdapter getMyVictoriesAll];
    
    FeedsResult *result = [myVictoriesData objectAtIndex: row];
    NSLog(@"Feeds IDddddddd :- %@",result.strFeedsId);
    
    
    viewVictoryDetailController  = [[VictoryDetailController alloc]initWithNibName:@"VictoryDetailController" bundle:nil];
    [self.view addSubview:viewVictoryDetailController.view];
}

- (void) dealloc 
{
    [myVictoriesData release];
    [restConnection release];
    [super dealloc];
}

@end
