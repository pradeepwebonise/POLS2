//
//  POLSAppDelegate.h
//  POLS
//
//  Created by nachi on 24/04/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface POLSAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UITabBarController *tcTabBar;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tcTabBar;

@end

