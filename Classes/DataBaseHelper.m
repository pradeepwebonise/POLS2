//
//  DataBaseHelper.m
//  POLS
//
//  Created by nachi on 30/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DataBaseHelper.h"
#import "POLSAppDelegate.h"

@implementation DataBaseHelper

@synthesize context;
@synthesize persistentStoreCoordinator;


-(id) init
{
    self = [super init];
    if(self)
    {
        POLSAppDelegate *polsAppDelegate = [[UIApplication sharedApplication] delegate];
        self.context = [polsAppDelegate managedObjectContext];
         //  inTransaction = NO;
    }
    return self;
}

- (void)insertIntoTable:(NSDictionary *)dictionary
{
    NSManagedObject *data;
    data = [NSEntityDescription insertNewObjectForEntityForName:dbName inManagedObjectContext:[self context]];
    for(id key in dictionary)
    {
        [data setValue:[dictionary objectForKey:key] forKey:key];
    }
    [self save];
}

-(void)deleteFromTable:(NSManagedObject*) mObject
{
    [context deletedObject:mObject];
    [self save];
}

-(NSArray *)fetch:(int)remoteId {
    NSFetchRequest *request = [[[NSFetchRequest alloc]init]autorelease];
    NSEntityDescription *entity = [NSEntityDescription entityForName:dbName inManagedObjectContext:context];
    [request setEntity:entity];
    
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"remote_id = %d", remoteId];
    //NSLog(@"DatabaseHelper::fetch with predicate %@ and id %d", predicate, remoteId);    
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *records = [context executeFetchRequest:request error:&error];
    return records;
    
}

- (NSArray *)fetchAll
{
    NSFetchRequest *request = [[[NSFetchRequest alloc]init] autorelease];
    NSEntityDescription *entity = [NSEntityDescription entityForName:dbName inManagedObjectContext:context];
    [request setEntity:entity];
    [request setPredicate:nil];
    NSError *error = nil;
    NSArray *records = [context executeFetchRequest:request error:&error];
    return records;
}

-(void) deleteAll 
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:dbName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    for (NSManagedObject *managedObject in items ) {
        [context deleteObject:managedObject];
    }
    [self save];
}


-(BOOL)save {
   // if (!inTransaction ) {
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Error saving transaction %@ - error:%@",dbName,error);
             return NO;
        } else{
            return YES;
        }
//        } else {
//            return YES; 
//        }
} 

//
//- (NSFetchedResultsController *)fetchedResultsController{
//    if (mfetchedResultsController) return mfetchedResultsController;
//    
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:dbName inManagedObjectContext:context];
//    [fetchRequest setEntity:entity];
//    
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:[dbColumns objectAtIndex:0] ascending:YES];
//    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];  
//    [fetchRequest setSortDescriptors:sortDescriptors];
//    
//    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
//    // aFetchedResultsController.delegate = self;
//    [self setFetchedResultsController:aFetchedResultsController];
//    mfetchedResultsController=aFetchedResultsController;
//    [aFetchedResultsController release];
//    [fetchRequest release];
//    [sortDescriptor release];
//    [sortDescriptors release];
//    
//    return mfetchedResultsController;        
//}


@end
