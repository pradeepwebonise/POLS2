//
//  MyFavouritesViewController.m
//  POLS
//
//  Created by nachi on 24/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyFavouritesViewController.h"

@implementation MyFavouritesViewController

@synthesize myFavouritesData;
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
    
    NSString *urlString = [NSString stringWithFormat:@""];
    [restConnection performRequest:
     [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
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
	NSLog(@"didReceiveResponse: %@", response);
}

- (void)finishedReceivingData:(NSData *)data
{
	NSLog(@"finishedReceivingData: %@", [restConnection stringData]);
    NSString *feedsReponse= [restConnection stringData];
    NSLog(@"MyFavourites Response: %@", feedsReponse);
    NSMutableArray *myFavouritesDataArray = [NSMutableArray array];
    myFavouritesDataArray = [FeedsResult parseFeedsData:feedsReponse];
    NSLog(@"%d",[myFavouritesDataArray count]);
    [self storeToDb:myFavouritesDataArray];
    [self readFromDb];
}

-(void) readFromDb
{
    MyFavouritesDbAdapter *myFavouritesDbAdapter = [[MyFavouritesDbAdapter alloc] init];
    myFavouritesData = [myFavouritesDbAdapter getMyFavouritesAll];
}

- (void) storeToDb:(NSMutableArray *)myFavouritesDataArray
{
    NSLog(@"%d",[myFavouritesDataArray count]);
    MyFavouritesDbAdapter *myFavouritesDbAdapter = [[MyFavouritesDbAdapter alloc] init];
    [myFavouritesDbAdapter deleteAll];
    
    for(int i=0;i<[myFavouritesDataArray count];i++)
    {
        FeedsResult *feedsResult = [myFavouritesDataArray objectAtIndex:i];
        [myFavouritesDbAdapter create:feedsResult];
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
    MyFavouritesDbAdapter *myFavouritesDbAdapter = [[MyFavouritesDbAdapter alloc] init];
    myFavouritesData = [myFavouritesDbAdapter getMyFavouritesAll];
    return [self.myFavouritesData count];
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
        
        MyFavouritesDbAdapter *myFavouritesDbAdapter = [[MyFavouritesDbAdapter alloc] init];
        myFavouritesData = [myFavouritesDbAdapter getMyFavouritesAll];
        
        FeedsResult *result = [myFavouritesData objectAtIndex: row];
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
    
    MyFavouritesDbAdapter *myFavouritesDbAdapter = [[MyFavouritesDbAdapter alloc] init];
    myFavouritesData = [myFavouritesDbAdapter getMyFavouritesAll];
    
    FeedsResult *result = [myFavouritesData objectAtIndex: row];
    NSLog(@"Feeds IDddddddd :- %@",result.strFeedsId);
    
    
    viewVictoryDetailController  = [[VictoryDetailController alloc]initWithNibName:@"VictoryDetailController" bundle:nil];
    [self.view addSubview:viewVictoryDetailController.view];
}

- (void) dealloc 
{
    [myFavouritesData release];
    [restConnection release];
    [super dealloc];
}

@end
