//
//  SwitchViewController.m
//  MusicPlayer
//
//  Created by Bill on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SwitchViewController.h"


@implementation SwitchViewController

@synthesize lyricsViewController;
@synthesize iPodLibrarySwitchViewController;
@synthesize mvSwitchViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]autorelease];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    lyricsViewController=[[LyricsViewController alloc] initWithNibName:@"LyricsView" bundle:nil];
    
    iPodLibrarySwitchViewController=[[IPodLibrarySwitchViewController alloc]init];
    
    mvSwitchViewController=[[MVSwitchViewController alloc]initWithNibName:@"MVSwitchViewController" bundle:nil];
    
    
    UITabBarItem *itemLibrary=[[UITabBarItem alloc]initWithTitle:@"音乐库" image:[UIImage imageNamed: @"MusicLibraryTabBarItem"] tag:2];
    
    UITabBarItem *itemPlaying=[[UITabBarItem alloc]initWithTitle:@"正在播放" image:[UIImage imageNamed:@"NowPlayingTabBarItem.png"] tag:1];
    
    UITabBarItem *itemMV=[[UITabBarItem alloc]initWithTitle:@"MV" image:nil tag:3];
    
    iPodLibrarySwitchViewController.tabBarItem=itemLibrary;
    
    lyricsViewController.tabBarItem=itemPlaying;
    
    mvSwitchViewController.tabBarItem=itemMV;
    
    self.delegate=self;
    self.viewControllers=[NSArray arrayWithObjects:lyricsViewController,iPodLibrarySwitchViewController,mvSwitchViewController,nil];
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSLog(@"%i",item.tag);//1开头
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(void)deallo{
    [lyricsViewController release];
    [super dealloc];
}

@end
