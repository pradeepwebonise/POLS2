//
//  FeedsViewController.h
//  POLS
//
//  Created by nachi on 24/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestConnection.h"
#import  "FeedsResult.h"
#import "FeedsDbAdapter.h"
#define baseURL @"http://pols-2.heroku.com/apis/"

@class RestConnection;

@interface FeedsViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource,RestConnectionDelegate> {
    NSArray *listData;
    UILabel *title;
    UILabel *postedBy;
    UILabel *onDate;
    UITableViewCell *tableViewCell;
    FeedsResult *objFeedsResult;
    @private
    RestConnection *restConnection;
   // NSMutableArray *feedsData;
}
@property(nonatomic,retain) NSArray *listData;
//@property (nonatomic,retain) NSMutableArray *feedsData;
@property (nonatomic,retain) IBOutlet UILabel *title;
@property(nonatomic,retain) IBOutlet UILabel *postedBy;
@property(nonatomic,retain) IBOutlet UILabel *onDate;
@property (nonatomic,retain)IBOutlet UITableViewCell *tableViewCell;

- (void) storeToDb:(NSMutableArray *)feedsData;
-(void) readFromDb;

@end
