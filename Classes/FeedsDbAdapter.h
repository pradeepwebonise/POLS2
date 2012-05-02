//
//  FeedsDbAdapter.h
//  POLS
//
//  Created by nachi on 02/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedsResult.h"
#import "DataBaseHelper.h"

@interface FeedsDbAdapter : DataBaseHelper
{
  
}

@property(nonatomic,retain) NSString *dbName;
@property(nonatomic,retain)  NSArray *dbColumns;

-(void)setDbName:(NSString*)databaseName;
-(void)setDbColumns;
-(void)create:(FeedsResult *) feedsResult;
-(void) deleteAll;
-(NSDate *)dateFromString:(NSString *)string;
-(NSMutableArray *) getFeedsAll;

@end
