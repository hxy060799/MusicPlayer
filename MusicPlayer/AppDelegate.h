//
//  AppDelegate.h
//  MusicPlayer
//
//  Created by Bill on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SwitchViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>

@property(strong, nonatomic) IBOutlet UIWindow *window;
@property(retain, nonatomic) IBOutlet SwitchViewController *switchViewController;

+(SwitchViewController*)switchViewController;

@end
