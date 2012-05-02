//
//  FeedsDbAdapter.m
//  POLS
//
//  Created by nachi on 02/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedsDbAdapter.h"

@implementation FeedsDbAdapter


- (id)init
{
    self = [super init];
    [self setDbName:@"Feeds"];
    [self setDbColumns];
    return self;
}

- (void) setDbName:(NSString *)databaseName
{
    dbName=databaseName;
}

- (void) setDbColumns
{
    dbColumns = [[NSArray alloc] initWithObjects:@"feeds_id",@"feeds_ondate",@"feeds_postedby",@"feeds_title", nil];
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
    NSLog(@"Data Stored successfully..!!");
}

-(NSMutableArray *) getFeedsAll
{
    NSArray *allFeedsData = [super fetchAll];
    NSMutableArray *feedsData = [[NSMutableArray new] autorelease]; 
    for(int i=0;i<[allFeedsData count];i++)
    {
        FeedsResult *feedsResult = [FeedsResult new];
        feedsResult.strFeedsId = [[(NSManagedObject *)[allFeedsData objectAtIndex:i] valueForKey:@"feeds_id"] stringValue];
        NSLog(@"Feeds id %@",feedsResult.strFeedsId);
        
        feedsResult.strFeedsTitle = [(NSManagedObject*)[allFeedsData objectAtIndex:i] valueForKey:@"feeds_title"];
        NSLog(@"Feeds Title %@",feedsResult.strFeedsTitle);
        
        feedsResult.strFeedsPostedBy = [(NSManagedObject*)[allFeedsData objectAtIndex:i] valueForKey:@"feeds_postedby"];
        NSLog(@"Feeds PostedBy %@",feedsResult.strFeedsPostedBy);
        
        feedsResult.strFeedsOnDate = [(NSManagedObject*)[allFeedsData objectAtIndex:i] valueForKey:@"feeds_ondate"];
        NSLog(@"Feeds Ondate %@", feedsResult.strFeedsOnDate);
                
        NSString *strdate = feedsResult.strFeedsOnDate;
        NSLog(@"%@",strdate);
        
        // ====================String to Date Conversion ===================
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
        NSDate *postedDate = [dateFormat dateFromString:strdate];
        NSLog(@"postedDate....%@",postedDate);
        
        NSCalendar *calendarStartTime = [NSCalendar currentCalendar];
        NSDateComponents *componentsStartTime = [calendarStartTime components:(kCFCalendarUnitHour | kCFCalendarUnitMinute) fromDate:postedDate];
        NSInteger StartHour = [componentsStartTime hour];

        NSInteger StartMinute = [componentsStartTime minute];
        
        // =================================================================
        [feedsData addObject:feedsResult];
        [feedsResult release];

    }
    return feedsData;
}

- (NSDate *)dateFromString:(NSString *)string
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormat setLocale:locale];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeInterval interval = 5 * 60 * 60;
    
    NSDate *date1 = [dateFormat dateFromString:string];  
    date1 = [date1 dateByAddingTimeInterval:interval];
    if(!date1) date1= [NSDate date];
    [dateFormat release];
    [locale release];
    
    return date1;
}

 @end
