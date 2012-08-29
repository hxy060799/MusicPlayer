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
@synthesize musicSearchViewController;

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
    musicSearchViewController=[[MusicSearchViewController alloc]initWithNibName:@"MusicSearchViewController" bundle:nil];
    
    
    UITabBarItem *itemLibrary=[[UITabBarItem alloc]initWithTitle:@"音乐库" image:[UIImage imageNamed: @"MusicLibraryTabBarItem"] tag:2];
    
    UITabBarItem *itemPlaying=[[UITabBarItem alloc]initWithTitle:@"正在播放" image:[UIImage imageNamed:@"NowPlayingTabBarItem.png"] tag:1];
    
    UITabBarItem *itemMV=[[UITabBarItem alloc]initWithTitle:@"MV" image:[UIImage imageNamed:@"MVTabBarItem"] tag:3];
    
    UITabBarItem *itemSearch=[[UITabBarItem alloc]initWithTitle:@"在线搜索" image:[UIImage imageNamed:@"OnlineSearchTabBarIcon"] tag:4];
    
    iPodLibrarySwitchViewController.tabBarItem=itemLibrary;
    
    lyricsViewController.tabBarItem=itemPlaying;
    
    mvSwitchViewController.tabBarItem=itemMV;
    
    musicSearchViewController.tabBarItem=itemSearch;
    
    self.delegate=self;
    self.viewControllers=[NSArray arrayWithObjects:lyricsViewController,iPodLibrarySwitchViewController,mvSwitchViewController,musicSearchViewController,nil];
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    //NSLog(@"%i",item.tag);
    if(item.tag==3){//tabBar的选中项,1开头
        if(mvSwitchViewController.firstLoaded==NO){
            [mvSwitchViewController loadHotMVData];
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation==UIInterfaceOrientationPortrait);
}

-(void)deallo{
    [lyricsViewController release];
    [super dealloc];
}

@end
