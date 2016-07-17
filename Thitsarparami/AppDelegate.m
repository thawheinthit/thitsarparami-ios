//
//  AppDelegate.m
//  Thitsarparami
//
//  Created by Thaw Hein Thit on 13/12/15.
//  Copyright © 2015 Thaw Hein Thit. All rights reserved.
//


#import "AppDelegate.h"
#import "Utility.h"
#import "Setting.h"
#import "RegisterService.h"
#import <AFNetworking/AFNetworking.h>

@interface AppDelegate ()
@end



@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    

    [[UINavigationBar appearance]setBarTintColor:[Utility colorFromHexString:@"#801423"]];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    
    
    [[UINavigationBar appearance] setTitleTextAttributes:
     @{
       NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName: [UIFont fontWithName:@"Zawgyi-One" size:14.0]
       }];
    
    [[UINavigationBar appearance]setTranslucent:NO];
    

    [[UITabBar appearance]setTintColor:[Utility colorFromHexString:@"#801423"]];
    
    
    // PUSH
    
//    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
//        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge
//                                                                                             |UIUserNotificationTypeSound
//                                                                                             |UIUserNotificationTypeAlert) categories:nil];
//        [application registerUserNotificationSettings:settings];
//    }
//    
//    application.applicationIconBadgeNumber = 0;
    
    
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
    
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString* tokenString = [[[[deviceToken description]
                               stringByReplacingOccurrencesOfString: @"<" withString: @""]
                              stringByReplacingOccurrencesOfString: @">" withString: @""]
                             stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    NSLog(@"token string %@", tokenString);
    

    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString *token = [userDefault objectForKey:@"deviceToken"];
    if (!token) {
        [userDefault setObject:tokenString forKey:@"deviceToken"];
        [userDefault synchronize];
        
        Setting *tmpSetting = [Setting new];
        tmpSetting.deviceName = @"";
        tmpSetting.deviceToken = tokenString;
        tmpSetting.notiStatus = @1;
        
        
        [[RegisterService addNewDevice:tmpSetting] subscribeError:^(NSError *error) {
            
            NSLog(@"Error222");
            
        } completed:^{
            NSLog(@"Complete!");
            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            [prefs setObject:@"YES" forKey:@"Push_Registered"];
            [prefs synchronize];
        }];
    }
    
//    
//    NSDictionary *parameters = @{ @"device_id" : tokenString, @"notification" : @"0", @"device_name": @"asfasdf" };
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//
//    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
//    [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.requestSerializer = serializer;
//    
//    
//    
//    [manager POST:@"http://thitsarparamisociety.com/ios/index.php/api/register" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
    

}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    //NSString *str = [NSString stringWithFormat: @"Error: %@", err];
    NSLog(@"Error %@",err);
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"receive Push %@", userInfo);

    [[NSNotificationCenter defaultCenter] postNotificationName:@"PushNotification" object:userInfo];
    
//    int badgeCount = (int)[UIApplication sharedApplication].applicationIconBadgeNumber;
//    badgeCount = badgeCount + 1;
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = [[[userInfo objectForKey:@"aps"] objectForKey: @"badgecount"] intValue];
    if ( application.applicationState == UIApplicationStateInactive)
    {
        //opened from a push notification when the app was on background
        
        NSLog(@"userInfo->%@",[userInfo objectForKey:@"aps"]);
    }
    else if(application.applicationState == UIApplicationStateActive)
    {
        // a push notification when the app is running. So that you can display an alert and push in any view
        
        NSLog(@"userInfo->%@",[userInfo objectForKey:@"aps"]);
    }

}

@end
