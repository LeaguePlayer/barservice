//
//  AppDelegate.m
//  barservice
//
//  Created by Leonid Minderov on 26.02.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "AppDelegate.h"
#import "ECSlidingViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   
    return YES;
}


//-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//{
//    NSString *UUIDString = nil;
//  //  NSLog(@"DEVICE TOKEN = %@", deviceToken);
//   UUIDString  = [[NSUUID UUID] UUIDString];
//    NSString *string = [NSString stringWithFormat:@"?deviceToken=%@&device=%@",deviceToken, UUIDString];
//    NSLog(@"%@",string);
//    string = [string substringWithRange:NSMakeRange(1, string.length-2)];
//    string = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    NSString *url = [NSString stringWithFormat:@"%@/site/adddevicetoken/%@",domain_server_api,string];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//    
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *urlResponse, NSData *data, NSError *error) {
//        if(error)
//        {
//            NSLog(@"error!");
//        }
//    }];
//    
//}


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
