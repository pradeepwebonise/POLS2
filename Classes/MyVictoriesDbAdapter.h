//
//  MyVictoriesDbAdapter.h
//  POLS
//
//  Created by nachi on 03/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "FeedsResult.h"
#import "DataBaseHelper.h"

@interface MyVictoriesDbAdapter : DataBaseHelper
{

}
-(void)setDbName:(NSString*)databaseName;
-(void)setDbColumns;
-(void)create:(FeedsResult *) feedsResult;
-(void) deleteAll;
-(NSMutableArray *) getMyVictoriesAll;
@end
