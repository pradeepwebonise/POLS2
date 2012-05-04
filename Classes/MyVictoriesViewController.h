//
//  FeedsViewController.h
//  POLS
//
//  Created by nachi on 24/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestConnection.h"
#import "VictoryDetailController.h"
#import "FeedsResult.h"
#import "MyVictoriesDbAdapter.h"
#define baseURL @"http://pols-2.heroku.com/apis/my_victories.js?AUTH_KEY=9819349370015737382199895&PAGE_NO=1"

@class RestConnection;

@interface MyVictoriesViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource,RestConnectionDelegate> {
    NSMutableArray *myVictoriesData;
    UILabel *lbTitle;
    UILabel *lbPostedBy;
    UILabel *lbOnDate;
    UITableViewCell *tableViewCell;
    VictoryDetailController *viewVictoryDetailController;
    FeedsResult *objFeedsResult;
@private
    RestConnection *restConnection;
    // NSMutableArray *feedsData;
}
@property (nonatomic,retain)NSMutableArray *myVictoriesData;
@property (nonatomic,retain)IBOutlet UILabel *lbTitle;
@property(nonatomic,retain) IBOutlet UILabel *lbPostedBy;
@property(nonatomic,retain) IBOutlet UILabel *lbOnDate;
@property (nonatomic,retain)IBOutlet UITableViewCell *tableViewCell;
@property(nonatomic,retain) VictoryDetailController *viewVictoryDetailController;

- (void) storeToDb:(NSMutableArray *)myVictoriesDataArray;
-(void) readFromDb;

@end

