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
    NSArray *dbColumns;

}

@property (nonatomic,retain) NSManagedObjectContext  *context;
@property (nonatomic,retain) NSPersistentStoreCoordinator *persistentStoreCoordinator;



-(void)insertIntoTable:(NSDictionary*)dictionary;
-(void) deleteAll;
-(void)deleteFromTable:(NSManagedObject*) mObject;
-(NSArray *)fetch:(int)remoteId;
-(NSArray *)fetchAll;
-(BOOL)save;
@end
