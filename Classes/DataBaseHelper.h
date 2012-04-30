//
//  DataBaseHelper.h
//  POLS
//
//  Created by nachi on 30/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DataBaseHelper : NSObject
{
    NSManagedObjectContext *context;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSString *dbName;
    NSString *dbColumns;
}

@property (nonatomic,retain) NSManagedObjectContext  *context;
@property (nonatomic,retain) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic,retain) NSString *dbName;
@property (nonatomic,retain) NSString *dbColumns;


-(void)insertIntoTable:(NSDictionary*)dictionary;


@end
