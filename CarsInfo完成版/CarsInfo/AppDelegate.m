//
//  AppDelegate.m
//  CarsInfo
//
//  Created by qianfeng000 on 15/9/17.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "UMSocial.h"
#import <JSPatchPlatform/JSPatch.h>


@interface AppDelegate ()
@property (nonatomic)RootViewController *RootVC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UMSocialData setAppKey:@"5606a5f9e0f55ac8570036da"];
    //jspatch
    [JSPatch startWithAppKey:@"6260ecea30eaaf69"];

    //发布前测试脚本 它是与setAppKey相对的
//    [JSPatch testScriptInBundle];
    //自定义RSA key
    [JSPatch setupRSAPublicKey:@"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDCnElfDeu+21jS1LvU1houJjet\n+/eWf2mrnw2WimTdM2f2yaE11/P6qcVBK2nGZZV2WbOqs3MfK3vGENNQPOp4a72a\nFvSLlIrudrZrC7QvndK4bP4aX/jmyr5KD/qPfnhnq3Bzjhfy0KPlYpHg/Af2VGWT\npFWxs6pBebrvH7vgRQIDAQAB\n-----END PUBLIC KEY-----"];
    //开发模式下发
#ifdef DEBUG
//    [JSPatch setupDevelopment];
#endif
    
    
    [NSThread sleepForTimeInterval:1];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    RootViewController *rootVC = [[RootViewController alloc] init];
    
    [self.window setRootViewController:rootVC];
    [self.window makeKeyAndVisible];
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
    
    [JSPatch sync];

    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
