//
//  FeedsDbAdapter.m
//  POLS
//
//  Created by nachi on 02/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyVictoriesDbAdapter.h"

@implementation MyVictoriesDbAdapter

- (id)init
{
    self = [super init];
    [self setDbName:@"MyVictories"];
    [self setDbColumns];
    return self;
}

- (void) setDbName:(NSString *)databaseName
{
    dbName=databaseName;
}

- (void) setDbColumns
{
    dbColumns = [[NSArray alloc] initWithObjects:@"myvictories_id",@"myvictories_ondate",@"myvictories_postedby",@"myvictories_title", nil];
}

- (void) deleteAll
{
    [super deleteAll];
}

- (void) create:(FeedsResult *) feedsResult
{
    NSArray *objects = [NSArray arrayWithObjects:feedsResult.strFeedsId, feedsResult.strFeedsTitle,feedsResult.strFeedsPostedBy,feedsResult.strFeedsOnDate, nil]; 
    NSArray *keys = [[NSArray alloc] initWithObjects:[dbColumns objectAtIndex:0],[dbColumns objectAtIndex:3],[dbColumns objectAtIndex:2],[dbColumns objectAtIndex:1],nil];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    [super insertIntoTable:dictionary];
    [keys release];
    NSLog(@"Data Stored successfully in myvictories..!!");
}

-(NSMutableArray *) getMyVictoriesAll
{
    NSArray *allFeedsData = [super fetchAll];
    NSMutableArray *feedsData = [[NSMutableArray new] autorelease]; 
    for(int i=0;i<[allFeedsData count];i++)
    {
        FeedsResult *feedsResult = [FeedsResult new];
        feedsResult.strFeedsId = [[(NSManagedObject *)[allFeedsData objectAtIndex:i] valueForKey:@"myvictories_id"] stringValue];
        NSLog(@"myvictories id %@",feedsResult.strFeedsId);
        
        feedsResult.strFeedsTitle = [(NSManagedObject*)[allFeedsData objectAtIndex:i] valueForKey:@"myvictories_title"];
        NSLog(@"myvictories Title %@",feedsResult.strFeedsTitle);
        
        feedsResult.strFeedsPostedBy = [(NSManagedObject*)[allFeedsData objectAtIndex:i] valueForKey:@"myvictories_postedby"];
        NSLog(@"myvictories PostedBy %@",feedsResult.strFeedsPostedBy);
        
        feedsResult.strFeedsOnDate = [(NSManagedObject*)[allFeedsData objectAtIndex:i] valueForKey:@"myvictories_ondate"];
        NSLog(@"myvictories Ondate %@", feedsResult.strFeedsOnDate);
        
        NSString *strdate = feedsResult.strFeedsOnDate;
        NSLog(@"%@",strdate);
        
        [feedsData addObject:feedsResult];
        [feedsResult release];
        
    }
    return feedsData;
}

@end
