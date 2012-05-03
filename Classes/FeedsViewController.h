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
#import "FeedsDbAdapter.h"
#define baseURL @"http://pols-2.heroku.com/apis/"

@class RestConnection;

@interface FeedsViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource,RestConnectionDelegate> {
    NSArray *listData;
    NSMutableArray *feedsData;
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
@property(nonatomic,retain) NSArray *listData;
@property (nonatomic,retain)NSMutableArray *feedsData;
@property (nonatomic,retain)IBOutlet UILabel *lbTitle;
@property(nonatomic,retain) IBOutlet UILabel *lbPostedBy;
@property(nonatomic,retain) IBOutlet UILabel *lbOnDate;
@property (nonatomic,retain)IBOutlet UITableViewCell *tableViewCell;
@property(nonatomic,retain) VictoryDetailController *viewVictoryDetailController;

- (void) storeToDb:(NSMutableArray *)feedsData;
-(void) readFromDb;

@end
