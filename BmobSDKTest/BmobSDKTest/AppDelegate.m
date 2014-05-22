//
//  AppDelegate.m
//  BmobSDKDemo
//
//  Created by Bmob on 13-11-28.
//  Copyright (c) 2013年 Bmob. All rights reserved.
//

#import "AppDelegate.h"
#import <BmobSDK/Bmob.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.mainViewController = [[[MainViewController alloc] init] autorelease];
    UINavigationController *rootNavigationController = [[[UINavigationController alloc] initWithRootViewController:self.mainViewController] autorelease];
    
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
    
    self.window.rootViewController = rootNavigationController;
    
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

//remoteNotifications
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    NSLog(@"didRegisterForRemoteNotificationsWithDeviceToken%@",deviceToken);
    
    BmobInstallation  *currentIntallation = [BmobInstallation currentInstallation];
    [currentIntallation setDeviceTokenFromData:deviceToken];
    [currentIntallation saveInBackground];
    
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    NSLog(@"userInfo %@",[userInfo description]);
    

    [BmobPush handlePush:userInfo];
}

@end
