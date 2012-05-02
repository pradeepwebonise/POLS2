//
//  FeedsViewController.m
//  POLS
//
//  Created by nachi on 24/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedsViewController.h"


@implementation FeedsViewController
@synthesize listData;
@synthesize title;
@synthesize postedBy;
@synthesize onDate;
@synthesize tableViewCell;


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
    NSLog(@"feedsResponse: %@", feedsReponse);
    objFeedsResult = [FeedsResult new];
    NSMutableArray *feedsData = [NSMutableArray array];
    feedsData = [FeedsResult parseFeedsData:feedsReponse];
    NSLog(@"%d",[feedsData count]);
    [self storeToDb:feedsData];
    [self readFromDb];
}

-(void) readFromDb
{
    FeedsDbAdapter *feedsDbAdapter = [[FeedsDbAdapter alloc] init];
    NSMutableArray *feedsData = [feedsDbAdapter getFeedsAll];
}

- (void) storeToDb:(NSMutableArray *)feedsData
{
    NSLog(@"%d",[feedsData count]);
    FeedsDbAdapter *feedsDbAdapter = [[FeedsDbAdapter alloc] init];
    [feedsDbAdapter deleteAll];
        
    for(int i=0;i<[feedsData count];i++)
    {
        FeedsResult *feedsResult = [feedsData objectAtIndex:i];
        [feedsDbAdapter create:feedsResult];
        
        NSLog(@"ID:   %@",feedsResult.strFeedsId);
        NSLog(@"Title:   %@",feedsResult.strFeedsTitle);
        NSLog(@"Posted By:   %@",feedsResult.strFeedsPostedBy);
        NSLog(@"OnDate:   %@",feedsResult.strFeedsOnDate);
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
    return [self.listData count];
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
        
        title.text=[listData objectAtIndex:row];
        title.text=@"Score FC";
        postedBy.text=@"Posted By: Nilesh";
        onDate.text=@"On: 2012-12-01";
        
        
        
        // =======================================================
//        
//        FeedsDbAdapter *feedsDbAdapter = [[FeedsDbAdapter alloc] init];
//        NSMutableArray *feedsData = [feedsDbAdapter getFeedsAll];
        
//        
//        for(int i=0;i<[feedsData count];i++)
//        {
//            FeedsResult *feedsResult = [FeedsResult new];
//            feedsResult.strFeedsId = [[(NSManagedObject *)[feedsData objectAtIndex:i] valueForKey:@"feeds_id"] stringValue];
//            NSLog(@"Feeds id %@",feedsResult.strFeedsId);
//          //  title.text = feedsResult.strFeedsId;
//            
//            feedsResult.strFeedsTitle = [(NSManagedObject*)[feedsData objectAtIndex:i] valueForKey:@"feeds_title"];
//            NSLog(@"Feeds Title %@",feedsResult.strFeedsTitle);
//            
//            feedsResult.strFeedsPostedBy = [(NSManagedObject*)[feedsData objectAtIndex:i] valueForKey:@"feeds_postedby"];
//            NSLog(@"Feeds PostedBy %@",feedsResult.strFeedsPostedBy);
//            
//            feedsResult.strFeedsOnDate = [(NSManagedObject*)[feedsData objectAtIndex:i] valueForKey:@"feeds_ondate"];
//            NSLog(@"Feeds Ondate %@", feedsResult.strFeedsOnDate);
//            
//            NSString *strdate = feedsResult.strFeedsOnDate;
//            NSLog(@"%@",strdate);
//            
//            // ====================String to Date Conversion ===================
//            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//            [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
//            NSDate *postedDate = [dateFormat dateFromString:strdate];
//            NSLog(@"postedDate....%@",postedDate);
//            
//            NSCalendar *calendarStartTime = [NSCalendar currentCalendar];
//            NSDateComponents *componentsStartTime = [calendarStartTime components:(kCFCalendarUnitHour | kCFCalendarUnitMinute) fromDate:postedDate];
//            NSInteger StartHour = [componentsStartTime hour];
//            
//            NSInteger StartMinute = [componentsStartTime minute];
//            
//            // =================================================================
//            [feedsData addObject:feedsResult];
//            [feedsResult release];
//            
//        }

         // =======================================================
        
    }
   
   return cell;
}



- (void) dealloc 
{
    //[listData release];
    //[restConnection release];
    [super dealloc];
}

@end
