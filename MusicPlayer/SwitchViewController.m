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
//@synthesize iPodLibrarySwitchViewController_;
//@synthesize iPodLibraryViewController;
@synthesize iPodLibrarySwitchViewController;

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
    
    UITabBarItem *itemLibrary=[[UITabBarItem alloc]initWithTitle:@"音乐库" image:[UIImage imageNamed: @"MusicLibraryTabBarItem"] tag:2];
    
    UITabBarItem *itemPlaying=[[UITabBarItem alloc]initWithTitle:@"正在播放" image:[UIImage imageNamed:@"NowPlayingTabBarItem.png"] tag:1];
    
    iPodLibrarySwitchViewController.tabBarItem=itemLibrary;
    
    lyricsViewController.tabBarItem=itemPlaying;
    
    self.delegate=self;
    self.viewControllers=[NSArray arrayWithObjects:lyricsViewController,iPodLibrarySwitchViewController,nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)showLyricsView{
    if(lyricsViewController==nil){
        lyricsViewController=[[LyricsViewController alloc] initWithNibName:@"LyricsView" bundle:nil];
    }
    [self removeAllView];
    [self.view insertSubview:lyricsViewController.view atIndex:0];
}

-(void)showiPodSelectShitchView{
    //if(self.iPodLibrarySwitchViewController_==nil){
    //    self.iPodLibrarySwitchViewController_=[[IPodLibrarySwitchViewController alloc]init];
    //}
    //[self removeAllView];
    //[self.view insertSubview:iPodLibrarySwitchViewController_.view atIndex:0];
}

-(void)showMainView{
    [self showLyricsView];
}

-(void)removeAllView{
    if(lyricsViewController.view){
        [lyricsViewController.view removeFromSuperview];
    }
    //if(iPodLibrarySwitchViewController_.view){
    //    [iPodLibrarySwitchViewController_.view removeFromSuperview];
    //}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)deallo{
    [lyricsViewController release];
    [super dealloc];
}

@end
