//
//  POLSAppDelegate.h
//  POLS
//
//  Created by nachi on 24/04/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class FeedsViewController;

@interface POLSAppDelegate : NSObject <UIApplicationDelegate> {
    
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    
    UIWindow *window;
    UITabBarController *tcTabBar;
    
@private
    FeedsViewController *feedsViewController;
        
}

@property (nonatomic,retain,readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain,readonly) NSPersistentStoreCoordinator  *persistentStoreCoordinator;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tcTabBar;

- (NSString *)applicationDocumentsDirectory;

@end

