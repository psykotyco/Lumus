//
//  LUAppDelegate.h
//  Lumus
//
//  Created by Ricardo Suarez on 11/12/12.
//  Copyright (c) 2012 Ricardo Suarez Martinez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LUMainViewController;

@interface LUAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@end
