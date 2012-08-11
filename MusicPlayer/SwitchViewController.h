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

@interface SwitchViewController : UITabBarController<UITabBarControllerDelegate>

@property(retain,nonatomic)LyricsViewController *lyricsViewController;
//@property(retain,nonatomic)IPodLibrarySwitchViewController *iPodLibrarySwitchViewController_;
//@property(retain,nonatomic)IPodLibraryViewController *iPodLibraryViewController;
@property(retain,nonatomic)IPodLibrarySwitchViewController *iPodLibrarySwitchViewController;

-(void)showLyricsView;
-(void)showiPodSelectShitchView;
-(void)showMainView;

@end
