//
//  FeedsResult.m
//  POLS
//
//  Created by nachi on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.

#import "FeedsResult.h"
#import "JSON.h"

@implementation FeedsResult

@synthesize strFeedsId;
@synthesize strFeedsTitle;
@synthesize strFeedsPostedBy;
@synthesize strFeedsOnDate;
@synthesize strProblem;
@synthesize strSolution;
@synthesize CommentsData,isFavUnFav;



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

+ (NSMutableArray *) parseVictoryDetailData: (NSString *) strVictoryDetailResponse
{
    NSMutableArray *victoryDetailValues = [NSMutableArray array];
    FeedsResult *objFeedsResult = [[FeedsResult alloc] init];
    NSDictionary *arrayData = (NSDictionary*)[strVictoryDetailResponse JSONValue];
    NSString *title = [arrayData objectForKey:@"title"];
    objFeedsResult.strFeedsTitle = title; //////
    // lbTitle.text=title;
    NSLog(@"Detail Title:::%@",title);
        
    Boolean isFavUnFavFlag = [[arrayData valueForKey:@"flag?"] boolValue];
    objFeedsResult.isFavUnFav=isFavUnFavFlag;

      
    NSString *user = [arrayData valueForKey:@"user"];
    // NSLog(@"Detail user:::%@",user);
    
    NSString *postedBy = [user valueForKey:@"name"];
   // lbPostedBy.text=postedBy;
    objFeedsResult.strFeedsPostedBy=postedBy;//////////
    
    
    NSLog(@"Detail postedBy:::%@",postedBy);
    
    NSString *OnDate = [arrayData objectForKey:@"created_at"];
    
    // ====================String to Date Conversion ===================
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    NSDate *postedDate = [dateFormat dateFromString:OnDate];
    NSLog(@"postedDate....%@",postedDate);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    //lbOnDate.text = [dateFormatter stringFromDate:postedDate];
    objFeedsResult.strFeedsOnDate = [dateFormatter stringFromDate:postedDate];////////
    [dateFormatter release];
    // ================================================================
    NSLog(@"Detail OnDate:::%@",postedDate);
    
    
    NSString *problem = [arrayData objectForKey:@"problem"];
  //  txtViewProblem.text=problem;
    objFeedsResult.strProblem = problem;////////
    NSLog(@"Detail Problem:::%@",problem);
    
    NSString *solution = [arrayData objectForKey:@"solution"];
  //  txtViewSolution.text=solution;
    objFeedsResult.strSolution=solution;///////////
    NSLog(@"Detail solution:::%@",solution);
    
    NSMutableArray *comments = [(NSDictionary*) [strVictoryDetailResponse JSONValue] objectForKey:@"comments"];
    NSLog(@"Detail Comments Array :::%@",comments);
    
    NSMutableArray *commentsArray =[self commentsParse:comments];
    objFeedsResult.CommentsData = commentsArray;
    
    [victoryDetailValues addObject:objFeedsResult];
    
    [objFeedsResult release];
    
    
    return victoryDetailValues;
    
}

+ (NSMutableArray *) commentsParse:(NSMutableArray*) comments
{
    NSMutableArray *commentsArray  = [NSMutableArray array];
    
    for(int i=0;i<[comments count];i++)
    {
         FeedsResult *objFeedsResult = [[FeedsResult alloc] init];
        NSDictionary *commentArray = [comments objectAtIndex:i];
        //NSLog(@"Comment Name :::%@",commentArray);
        
        NSString *commentTitle = [commentArray objectForKey:@"comment"];
        NSLog(@"Comments Name:::%@",commentTitle);
        objFeedsResult.strFeedsTitle = commentTitle;
        
        NSString *commentUser = [commentArray valueForKey:@"user"];
        NSString *commentPostedBy = [commentUser valueForKey:@"name"];
        NSLog(@"Comments PostedBy:::%@",commentPostedBy);
        objFeedsResult.strFeedsPostedBy=commentPostedBy;
        
        NSString *commentOnDate = [commentArray valueForKey:@"created_at"];
        
        // ====================String to Date Conversion ===================
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
        NSDate *postedDate = [dateFormat dateFromString:commentOnDate];
        NSLog(@"postedDate....%@",postedDate);
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
         objFeedsResult.strFeedsOnDate=  [dateFormatter stringFromDate:postedDate];
        [dateFormatter release];
        // ======================================================
        NSLog(@"Detail OnDate:::%@",postedDate);
       
        
        [commentsArray addObject:objFeedsResult];
        [objFeedsResult release];
    }
    return commentsArray;
}

@end
