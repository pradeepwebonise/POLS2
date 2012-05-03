//
//  MyFavouritesDbAdapter.m
//  POLS
//
//  Created by nachi on 03/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyFavouritesDbAdapter.h"

@implementation MyFavouritesDbAdapter

- (id)init
{
    self = [super init];
    [self setDbName:@"MyFavourites"];
    [self setDbColumns];
    return self;
}

- (void) setDbName:(NSString *)databaseName
{
    dbName=databaseName;
}

- (void) setDbColumns
{
    dbColumns = [[NSArray alloc] initWithObjects:@"myfavourites_id",@"myfavourites_ondate",@"myfavourites_postedby",@"myfavourites_title", nil];
}

- (void) deleteAll
{
    [super deleteAll];
}

- (void) create:(FeedsResult *)feedsResult
{
    NSArray *objects = [NSArray arrayWithObjects:feedsResult.strFeedsId, feedsResult.strFeedsTitle,feedsResult.strFeedsPostedBy,feedsResult.strFeedsOnDate, nil]; 
    NSArray *keys = [[NSArray alloc] initWithObjects:[dbColumns objectAtIndex:0],[dbColumns objectAtIndex:3],[dbColumns objectAtIndex:2],[dbColumns objectAtIndex:1],nil];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    [super insertIntoTable:dictionary];
    [keys release];
    NSLog(@"MyFavourites Data Stored successfully..!!");
}

-(NSMutableArray *) getMyFavouritesAll
{
    NSArray *allFeedsData = [super fetchAll];
    NSMutableArray *feedsData = [[NSMutableArray new] autorelease]; 
    for(int i=0;i<[allFeedsData count];i++)
    {
        FeedsResult *feedsResult = [FeedsResult new];
        feedsResult.strFeedsId = [[(NSManagedObject *)[allFeedsData objectAtIndex:i] valueForKey:@"myfavourites_id"] stringValue];
        NSLog(@"myfavourites id %@",feedsResult.strFeedsId);
        
        feedsResult.strFeedsTitle = [(NSManagedObject*)[allFeedsData objectAtIndex:i] valueForKey:@"myfavourites_title"];
        NSLog(@"myfavourites Title %@",feedsResult.strFeedsTitle);
        
        feedsResult.strFeedsPostedBy = [(NSManagedObject*)[allFeedsData objectAtIndex:i] valueForKey:@"myfavourites_postedby"];
        NSLog(@"myfavourites PostedBy %@",feedsResult.strFeedsPostedBy);
        
        feedsResult.strFeedsOnDate = [(NSManagedObject*)[allFeedsData objectAtIndex:i] valueForKey:@"myfavourites_ondate"];
        NSLog(@"myfavourites Ondate %@", feedsResult.strFeedsOnDate);
        
        NSString *strdate = feedsResult.strFeedsOnDate;
        NSLog(@"%@",strdate);
        
        [feedsData addObject:feedsResult];
        [feedsResult release];
        
    }
    return feedsData;

}

@end
