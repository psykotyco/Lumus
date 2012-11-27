//
//  LUAppDelegate.m
//  Lumus
//
//  Created by Ricardo Suarez on 11/12/12.
//  Copyright (c) 2012 Ricardo Suarez Martinez. All rights reserved.
//

#import "LUAppDelegate.h"

#import "LUViewController.h"
#import "LUMorseViewController.h"

#define TORCH_ICON @"torch.png"
#define MORSE_ICON @"morse.png"

@interface LUAppDelegate ()

-(void)customizeTabBar:(UITabBar *)tabBar;

@end

@implementation LUAppDelegate

#pragma mark - Class Functions

-(void)customizeTabBar:(UITabBar *)tabBar {
    
    NSArray *tabBarItems = tabBar.items;
    
    UITabBarItem *tabBarFirstItem = [tabBarItems objectAtIndex:0];
    UITabBarItem *tabBarSecondtItem = [tabBarItems objectAtIndex:1];
    
    [tabBarFirstItem setImage:[UIImage imageNamed:TORCH_ICON]];
    [tabBarFirstItem setTitle:@"Torch"];
    
    [tabBarSecondtItem setImage:[UIImage imageNamed:MORSE_ICON]];
    [tabBarSecondtItem setTitle:@"Morse"];
}

#pragma mark - Application Delegate Functions

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    UIViewController *torchViewController = [[LUViewController alloc] initWithNibName:@"LUViewController" bundle:nil];
    UIViewController *morseViewController = [[LUMorseViewController alloc] initWithNibName:@"LUMorseViewController" bundle:nil];
    
    self.tabBarController = [[UITabBarController alloc] init];
    [self.tabBarController setDelegate:self];
    self.tabBarController.viewControllers = @[torchViewController,morseViewController];
    
    [self customizeTabBar:self.tabBarController.tabBar];
    
    self.window.rootViewController = self.tabBarController;
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

#pragma mark - UITabBarControllerDelegate

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    NSArray *viewControllers = tabBarController.viewControllers;
    
    for (UIViewController *controller in viewControllers) {
        if (controller != viewController) {
            [controller viewWillDisappear:YES];
        }
    }
    
    [viewController viewWillAppear:YES];
    return YES;
}

@end
