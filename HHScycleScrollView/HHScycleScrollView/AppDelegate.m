//
//  AppDelegate.m
//  HHScycleScrollView
//
//  Created by 胡航 on 2019/10/16.
//  Copyright © 2019 胡航. All rights reserved.
//

#import "AppDelegate.h"
#import "HHBaseViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    
    HHBaseViewController *vc = [HHBaseViewController new];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController = nav;
    return YES;
}

@end
