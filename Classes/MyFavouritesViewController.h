//
//  MyFavouritesViewController.h
//  POLS
//
//  Created by nachi on 24/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestConnection.h"
#import "VictoryDetailController.h"
#import "FeedsResult.h"
#import "MyFavouritesDbAdapter.h"
#define baseURL @"http://pols-2.heroku.com/apis/my_favourites.js?AUTH_KEY=9819349370015737382199895&PAGE_NO=1"

@class RestConnection;

@interface MyFavouritesViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource,RestConnectionDelegate> {
    NSMutableArray *myFavouritesData;
    UILabel *lbTitle;
    UILabel *lbPostedBy;
    UILabel *lbOnDate;
    UITableViewCell *tableViewCell;
    VictoryDetailController *viewVictoryDetailController;
    FeedsResult *objFeedsResult;
@private
    RestConnection *restConnection;
}
@property(nonatomic,retain)NSMutableArray *myFavouritesData;
@property(nonatomic,retain)IBOutlet UILabel *lbTitle;
@property(nonatomic,retain)IBOutlet UILabel *lbPostedBy;
@property(nonatomic,retain)IBOutlet UILabel *lbOnDate;
@property(nonatomic,retain)IBOutlet UITableViewCell *tableViewCell;
@property(nonatomic,retain)VictoryDetailController *viewVictoryDetailController;

- (void) storeToDb:(NSMutableArray *)myFavouritesDataArray;
-(void) readFromDb;

@end
