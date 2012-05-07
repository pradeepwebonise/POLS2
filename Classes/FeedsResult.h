//
//  FeedsResult.h
//  POLS
//
//  Created by nachi on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface FeedsResult : NSObject
{
    NSString *strFeedsId;
    NSString *strFeedsTitle;
    NSString *strFeedsPostedBy;
    NSString *strFeedsOnDate;
    NSString *strProblem;
    NSString *strSolution;
    Boolean isFavUnFav;
    NSMutableArray *CommentsData;
}
@property (retain,nonatomic) NSString *strFeedsId;
@property (retain,nonatomic) NSString *strFeedsTitle;
@property (retain,nonatomic) NSString *strFeedsPostedBy;
@property (retain,nonatomic) NSString *strFeedsOnDate;
@property (retain,nonatomic) NSString *strProblem;
@property (retain,nonatomic) NSString *strSolution;
@property (retain,nonatomic) NSMutableArray *CommentsData;
@property (nonatomic) Boolean isFavUnFav;

+ (NSMutableArray *) parseFeedsData:(NSString *) strFeedsResponse;
+ (NSMutableArray *) parseVictoryDetailData: (NSString *) strVictoryDetailResponse;
+ (NSMutableArray *) commentsParse:(NSMutableArray*) comments;

@end
