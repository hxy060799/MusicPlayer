//
//  SwitchViewController.h
//  MusicPlayer
//
//  Created by Bill on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LyricsViewController.h"
#import "IPodLibrarySwitchViewController.h"
#import "MVSwitchViewController.h"
#import "MusicSearchViewController.h"

@interface SwitchViewController : UITabBarController<UITabBarControllerDelegate>

@property(retain,nonatomic)LyricsViewController *lyricsViewController;
@property(retain,nonatomic)MVSwitchViewController *mvSwitchViewController;
@property(retain,nonatomic)IPodLibrarySwitchViewController *iPodLibrarySwitchViewController;
@property(retain,nonatomic)MusicSearchViewController *musicSearchViewController;


@end
