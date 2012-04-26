//
//  FeedsResult.m
//  POLS
//
//  Created by nachi on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedsResult.h"

@implementation FeedsResult

@synthesize strFeedsId;
@synthesize strFeedsTitle;
@synthesize strFeedsPostedBy;
@synthesize strFeedsOnDate;


+ (FeedsResult *) parseFeedsData:(NSString *) strFeedsResponse
{
    FeedsResult *objFeedsResult = [[FeedsResult new] autorelease];
   // NSLog(@"FeedsResponse in Model: %@",strFeedsResponse);
  //  NSArray *feedsData = [strFeedsResponse JSONVal];
    NSArray *feedsData = [[NSArray alloc] init];
   // feedsData = [strFeedsResponse JSONVal];
    NSMutableArray *feedsValues = [[NSMutableArray alloc] init];
    for(NSDictionary *item in feedsData)
    {
        
        //[ids addObject:[item objectForKey:@"id"]];
        //NSLog(@"ID: %@",[item objectForKey:@"id"]);
    }
    [feedsData release];
    [feedsValues release];
    return objFeedsResult;
}
@end
