//
//  PLAppDelegate.m
//  Plate
//
//  Created by emileleon on 11/25/13.
//  Copyright (c) 2013 Plate SF. All rights reserved.
//

#import "PLAppDelegate.h"
#import "PLOrderNavigationController.h"
#import "PLBaseRewardsViewController.h"
#import "PLBaseAccountViewController.h"
#import "PLBaseMenuViewController.h"
#import "TestFlight.h"

@implementation PLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [TestFlight takeOff:@"7e7b66b2-35a9-4033-b76e-c6c1f0c9581c"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    //Init each of the tab bar's controllers
    PLOrderNavigationController *plhvc = [[PLOrderNavigationController alloc]initWithNibName:@"PLOrderNavigationController" bundle:nil];
    PLBaseMenuViewController *plmvc = [[PLBaseMenuViewController alloc]init];
    PLBaseRewardsViewController *plrvc = [[PLBaseRewardsViewController alloc]init];
    PLBaseAccountViewController *plsvc = [[PLBaseAccountViewController alloc]init];
    
    UITabBarController *tabBarController = [[UITabBarController alloc]init];

    //    UINavigationController *masterNav = [[UINavigationController alloc] initWithRootViewController:plhvc];

    NSArray *viewControllers = [NSArray arrayWithObjects:plhvc, plmvc, plrvc, plsvc, nil];
    [tabBarController setViewControllers:viewControllers];

    [[self window] setRootViewController:tabBarController];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
