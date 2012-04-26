//
//  POLSAppDelegate.h
//  POLS
//
//  Created by nachi on 24/04/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FeedsViewController;

@interface POLSAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UITabBarController *tcTabBar;
    
@private
    FeedsViewController *feedsViewController;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tcTabBar;

@end

