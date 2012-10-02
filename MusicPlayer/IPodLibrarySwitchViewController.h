//
//  IPodLibrarySwitchViewController.h
//  iPodLibraryViews
//
//  Created by Bill on 12-7-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IPodLibraryMainViewController.h"
#import "CoverFlowViewController.h"
#import "SongsTableViewController.h"
#import "Constents.h"

extern BOOL musicSynced;
extern NSMutableArray *musicByTitle;

@interface IPodLibrarySwitchViewController : UIViewController{
    IPodLibraryMainViewController *mainViewController;
    SongsTableViewController *allSongsViewController;
    SongsTableViewController *albumController;
    CoverFlowViewController *coverFlowViewController;
    SongsTableViewController *albumSongsViewController;
    SongsTableViewController *artistViewController;
    SongsTableViewController *artistSongViewController;
    
    UIViewController *current;
    
    UIViewController *viewToRemove;
}

-(void)changeToAllSongsView;
-(void)changeToIPodLibraryMainViewWithNowController:(SongsTableViewController*)controller;
-(void)changeToAlbumController;
-(void)changeBackToAlbumController;
-(void)changeBackToArtistController;
-(void)changeToCoverFlowView;
-(void)changeToAlbumSongsViewWithIndex:(int)index;
-(void)changeToArtistView;
-(void)changeToArtistSongsViewWithIndex:(int)index;

@end
