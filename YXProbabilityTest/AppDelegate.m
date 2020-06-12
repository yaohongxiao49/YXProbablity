//
//  AppDelegate.m
//  YXProbabilityTest
//
//  Created by ios on 2020/6/11.
//  Copyright © 2020 August. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if (@available(iOS 11.0, *)) {
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }
    
//    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:@"Zapfino" size:20]};
//    [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:2.0/255 green:34.0/255 blue:70.0/255 alpha:1];
    
    ViewController *rootVC = [[ViewController alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootVC];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
