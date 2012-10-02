//
//  AppDelegate.m
//  MusicPlayer
//
//  Created by Bill on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "Loading.h"

@implementation AppDelegate

@synthesize window;
@synthesize switchViewController;

- (void)dealloc
{
    [window release];
    [switchViewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    Loading *loading=[[Loading alloc]init];
    NSLog(@"Loading......");
    [loading query];
    [loading release];
    
    window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    switchViewController=[[SwitchViewController alloc] init];
    switchViewController.delegate=self;
    //[switchViewController showMainView];
    self.window.rootViewController=switchViewController;
    [self.window makeKeyAndVisible];
     
    return YES;
}

-(void)applicationDidEnterBackground:(UIApplication *)application{

}

+(AppDelegate*)app{
    return (AppDelegate*)[[UIApplication sharedApplication]delegate];
}

+(SwitchViewController*)switchViewController{
    return ((AppDelegate*)[[UIApplication sharedApplication]delegate]).switchViewController;
}

@end
