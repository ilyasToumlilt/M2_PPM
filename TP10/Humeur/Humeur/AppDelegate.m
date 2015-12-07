//
//  AppDelegate.m
//  Humeur
//
//  Created by m2sar on 05/12/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
    @property (retain) MoodSplitViewController *mySVC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    

    self.mySVC = [[MoodSplitViewController alloc] init];
    
    UINavigationController *nmvc = [[UINavigationController alloc] initWithRootViewController:self.mySVC.masterVC];
    UINavigationController *ndvc = [[UINavigationController alloc] initWithRootViewController:self.mySVC.detailsVC];
    
    [self.mySVC setViewControllers:[NSArray arrayWithObjects:nmvc, ndvc, nil]];
    [self.mySVC setDelegate:self.mySVC.masterVC];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone &&
        [[UIScreen mainScreen] scale] != 3.0) {
        UIViewController* containerVC = [[UIViewController alloc] init];
        [[containerVC view] addSubview:self.mySVC.view];
        UITraitCollection* myTC = [UITraitCollection traitCollectionWithVerticalSizeClass:UIUserInterfaceSizeClassCompact];
        [containerVC setOverrideTraitCollection:myTC forChildViewController:self.mySVC];
        [self.mySVC setPreferredDisplayMode:UISplitViewControllerDisplayModeAutomatic];
        [_window setRootViewController:containerVC];
        [containerVC release];
    } else {
        [_window setRootViewController:self.mySVC];
        [self.mySVC setPreferredDisplayMode:UISplitViewControllerDisplayModeAutomatic];
        if ([[UIScreen mainScreen] bounds].size.width < [[UIScreen mainScreen] bounds].size.height) {
            // N'afficher le bouton qu'en mode portrait
            [[[ndvc topViewController] navigationItem] setLeftBarButtonItem:[self.mySVC displayModeButtonItem]];
            [[[ndvc topViewController] navigationItem] setLeftItemsSupplementBackButton:YES];
        }
    }
    [_window makeKeyAndVisible];
    
    // releasing stuff
    [nmvc release];
    [ndvc release];
    [self.self.mySVC release];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"applicationDidBecomeActive");

    /*if([[NSUserDefaults standardUserDefaults]stringForKey:@"pseudo_preference"] != nil){
        [self.mySVC setPseudo:[[NSUserDefaults standardUserDefaults]stringForKey:@"pseudo_preference"] ];
    }*/
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
