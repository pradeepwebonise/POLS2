//
//  FeedsResult.m
//  POLS
//
//  Created by nachi on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedsResult.h"
#import "JSON.h"

@implementation FeedsResult

@synthesize strFeedsId;
@synthesize strFeedsTitle;
@synthesize strFeedsPostedBy;
@synthesize strFeedsOnDate;


+ (NSMutableArray *) parseFeedsData:(NSString *) strFeedsResponse
{
    //FeedsResult *objFeedsResult = [[FeedsResult new] autorelease];
    NSLog(@"FeedsResponse in Model: %@",strFeedsResponse);
    NSArray *feedsData = [strFeedsResponse JSONValue];
    NSMutableArray *feedsValues = [NSMutableArray array];
    for(int i=0;i<[feedsData count];i++)
    {
        NSDictionary *tempDictionary = [feedsData objectAtIndex:i];
        FeedsResult *objFeedsResult = [[FeedsResult alloc] init];
        
        NSString * feedsId = [tempDictionary valueForKey:@"id"];
        objFeedsResult.strFeedsId = [tempDictionary valueForKey:@"id"];
        NSLog(@"ID: %@",feedsId);
        
        
        NSString *feedsTitle=[tempDictionary valueForKey:@"title"];
        objFeedsResult.strFeedsTitle = [tempDictionary valueForKey:@"title"];
        NSLog(@"Title: %@",feedsTitle);
        
        NSString *feedsOnDate = [tempDictionary valueForKey:@"created_at"];
        objFeedsResult.strFeedsOnDate = [tempDictionary valueForKey:@"created_at"];
        NSLog(@"OnDate: %@",feedsOnDate);
        
        NSString *feedsUser = [tempDictionary valueForKey:@"user"];
       // NSLog(@"User: %@",feedsUser);
        
        NSString *feedsPostedBy = [feedsUser valueForKey:@"name"];
        NSLog(@"PostedBy: %@",feedsPostedBy);
        objFeedsResult.strFeedsPostedBy = [feedsUser valueForKey:@"name"];
        [feedsValues addObject:objFeedsResult];
        
        [objFeedsResult release];
    }
    return feedsValues;
}
@end
