//
//  VictoryDetailController.m
//  POLS
//
//  Created by nachi on 03/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VictoryDetailController.h"
#import "JSON.h"
#import "FeedsViewController.h"

@implementation VictoryDetailController
@synthesize lbTitle;
@synthesize btnFavUnFav;
@synthesize lbOnDate;
@synthesize lbPostedBy;
@synthesize txtViewProblem;
@synthesize txtViewSolution;
@synthesize txtFieldComment;
@synthesize btnPost;
@synthesize commentsData;
@synthesize tableview;

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
-(void) viewWillAppear:(BOOL)animated
{
 self.view.frame = CGRectMake(0, 0, 320,611);
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"############%d",[commentsData count]);
    NSLog(@"Comments data -%@",commentsData);
    return [self.commentsData count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *feedsTableIdentifier = @"FeedsTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:feedsTableIdentifier];
    if(cell==nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"FeedsTableViewCell" owner:self options:nil];
        cell=tableViewCell;
       // self.tableViewCell=nil;
        NSUInteger row = [indexPath row];
        NSLog(@"%d ",row);
        
        FeedsResult *result = [commentsData objectAtIndex:row];
        lbTitle.text = result.strFeedsTitle;
        lbPostedBy.text = result.strFeedsPostedBy;
        lbOnDate.text = result.strFeedsOnDate;
       // self.tableViewCell=nil;
    }
    
    return  cell;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.commentsData = [[NSMutableArray alloc] init];
    restConnection =[[RestConnection new]autorelease];
    restConnection.baseURLString=@"http://pols-2.heroku.com/apis/victory_detail.js?AUTH_KEY=9819349370015737382199895&VICTORY_ID=305";
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
    NSMutableArray *victoryData = [FeedsResult parseVictoryDetailData:victoryDetailReponse];
    [self showData:victoryData];
}

-(void) showData:(NSMutableArray *) victoryData
{
    FeedsResult *objFeedsResult = [[FeedsResult alloc] init];   
    objFeedsResult = [victoryData objectAtIndex:0];
    NSString *title = objFeedsResult.strFeedsTitle;
    NSLog(@"Shows Title:::%@", title);
    lbTitle.text= title;
    
    Boolean isFavUnFav = objFeedsResult.isFavUnFav;
    if(isFavUnFav)
    {
        UIImage *imgFavUnFav = [UIImage imageNamed:@"star_icon_yellow.png"];
        [btnFavUnFav setImage:imgFavUnFav forState:UIControlStateNormal];;
        [imgFavUnFav release];
    }
    else
    {
       UIImage *imgFavUnFav = [UIImage imageNamed:@"star_icon_gray.png"];
       [btnFavUnFav setImage:imgFavUnFav forState:UIControlStateNormal];;
       [imgFavUnFav release];
    }
         
    NSString *postedBy = objFeedsResult.strFeedsPostedBy;
    NSLog(@"Shows PostedBy:::%@", postedBy);
    lbPostedBy.text=postedBy;
    
    NSString *onDate = objFeedsResult.strFeedsOnDate;
    NSLog(@"Shows OnDate:::%@", onDate);
    lbOnDate.text=onDate;
    
    NSString *problem = objFeedsResult.strProblem;
    NSLog(@"Shows Problem:::%@", problem);
    txtViewProblem.text=problem;
    
    NSString *solution = objFeedsResult.strSolution;
    NSLog(@"Shows Solution:::%@", solution);
    txtViewSolution.text=solution;
        
    commentsData = objFeedsResult.CommentsData;
    [self commentshow:commentsData];
    [tableview reloadData];
}
-(void) commentshow:(NSMutableArray*) commentsData
{
    for(int i=0;i<[commentsData count];i++)
    {
        FeedsResult *objFeedsResult = [[FeedsResult alloc] init];
        objFeedsResult = [commentsData objectAtIndex:i];
        NSLog(@"Comments Name:::%@",objFeedsResult.strFeedsTitle);
        NSLog(@"Comments PostedBy:::%@",objFeedsResult.strFeedsPostedBy);
        NSLog(@"Comment PostedDate....%@",objFeedsResult.strFeedsOnDate);
    }
}

-(IBAction)onBarButtonItemClick:(id)sender {
    FeedsViewController *feedsViewController = [[FeedsViewController alloc]initWithNibName:@"FeedsViewController" bundle:nil];
    [self.view addSubview:feedsViewController.view];
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
