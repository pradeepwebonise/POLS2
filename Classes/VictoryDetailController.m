//
//  VictoryDetailController.m
//  POLS
//
//  Created by nachi on 03/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VictoryDetailController.h"
#import "JSON.h"

@implementation VictoryDetailController
@synthesize lbTitle;
@synthesize btnFavUnFav;
@synthesize lbOnDate;
@synthesize lbPostedBy;
@synthesize txtViewProblem;
@synthesize txtViewSolution;
@synthesize txtFieldComment;
@synthesize btnPost;

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
    NSString *victoryDetailReponse= [restConnection stringData];
    [self showData:victoryDetailReponse];
}

-(void) showData:(NSString *) victoryDetailReponse
{
    NSDictionary *arrayData = (NSDictionary*)[victoryDetailReponse JSONValue];
    NSString *title = [arrayData objectForKey:@"title"];
    lbTitle.text=title;
    NSLog(@"Detail Title:::%@",title);
    
    NSString *user = [arrayData valueForKey:@"user"];
   // NSLog(@"Detail user:::%@",user);
    
    NSString *postedBy = [user valueForKey:@"name"];
    lbPostedBy.text=postedBy;
    NSLog(@"Detail postedBy:::%@",postedBy);
    
    NSString *OnDate = [arrayData objectForKey:@"created_at"];
    
    // ====================String to Date Conversion ===================
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    NSDate *postedDate = [dateFormat dateFromString:OnDate];
    NSLog(@"postedDate....%@",postedDate);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    lbOnDate.text = [dateFormatter stringFromDate:postedDate];
    [dateFormatter release];
    // ======================================================
    NSLog(@"Detail OnDate:::%@",postedDate);
    
    NSString *problem = [arrayData objectForKey:@"problem"];
    txtViewProblem.text=problem;
    NSLog(@"Detail Problem:::%@",problem);
    
    NSString *solution = [arrayData objectForKey:@"solution"];
    txtViewSolution.text=solution;
    NSLog(@"Detail solution:::%@",solution);
    
    NSString *comments = [arrayData objectForKey:@"comments"];
    NSLog(@"Detail Comments:::%@",comments);
    [self commentsParse:comments];    
    
}
-(void) commentsParse:(NSString*) comments
{
//    NSArray *commentsData = [comments JSONValue];
//    for(int i=0;i<[commentsData count];i++)
//    {
//        NSDictionary *dictionary = [commentsData objectAtIndex:i];
//        NSString *commentTitle = [dictionary valueForKey:@"comment"];
//         NSLog(@"Comments Name:::%@",commentTitle);
//        
//        NSString *commentUser = [dictionary valueForKey:@"user"];
//        NSString *commentPostedBy = [commentUser valueForKey:@"name"];
//        
//        NSLog(@"Comments PostedBy:::%@",commentPostedBy);
//        
        
//        NSString *commentOnDate = [dictionary valueForKey:@"created_at"];
//        // ====================String to Date Conversion ===================
//        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//        [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
//        NSDate *postedDate = [dateFormat dateFromString:commentOnDate];
//        NSLog(@"postedDate....%@",postedDate);
//        
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
//        
//        lbOnDate.text = [dateFormatter stringFromDate:postedDate];
//        [dateFormatter release];
//        // ======================================================
//        NSLog(@"Detail OnDate:::%@",postedDate);

        
  //  }
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

-(void) dealloc
{
    [restConnection release];
    [super dealloc];
}

@end
