//
//  VictoryDetailController.h
//  POLS
//
//  Created by nachi on 03/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestConnection.h"
#import "FeedsResult.h"
#define baseURL @"http://pols-2.heroku.com/apis/victory_detail.js?AUTH_KEY=9819349370015737382199895&VICTORY_ID=305"

@class  RestConnection;
@interface VictoryDetailController : UIViewController
<UITableViewDelegate, UITableViewDataSource, RestConnectionDelegate>
{
    UILabel *lbTitle;
    UIButton *btnFavUnFav;
    UILabel *lbPostedBy;
    UILabel *lbOnDate;
    UITextView *txtViewProblem;
    UITextView *txtViewSolution;
    UITextField *txtFieldComment;
    UIButton *btnPost;
@private 
    RestConnection *restConnection;
}
@property(nonatomic,retain) IBOutlet UILabel *lbTitle;
@property(nonatomic,retain) IBOutlet UIButton *btnFavUnFav;
@property(nonatomic,retain) IBOutlet UILabel *lbPostedBy;
@property(nonatomic,retain) IBOutlet UILabel *lbOnDate;
@property(nonatomic,retain) IBOutlet UITextView *txtViewProblem;
@property(nonatomic,retain) IBOutlet UITextView *txtViewSolution;
@property(nonatomic,retain) IBOutlet UITextField *txtFieldComment;
@property(nonatomic,retain) IBOutlet UIButton *btnPost;

-(void) showData:(NSMutableArray *) victoryData;
-(void) commentshow:(NSMutableArray*) commentsData;

-(IBAction)onBarButtonItemClick:(id)sender;

@end
