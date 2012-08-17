//
//  IPodLibrarySwitchViewController.h
//  iPodLibraryViews
//
//  Created by Bill on 12-7-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IPodLibraryMainViewController.h"
#import "AllSongsViewController.h"
#import "AlbumViewController.h"
#import "CoverFlowViewController.h"
#import "AlbumSongsViewController.h"
#import "Constents.h"

extern BOOL musicSynced;
extern NSMutableArray *musicByTitle;



@interface IPodLibrarySwitchViewController : UIViewController{
    IPodLibraryMainViewController *mainViewController;
    AllSongsViewController *allSongsViewController;
    AlbumViewController *albumController;
    CoverFlowViewController *coverFlowViewController;
    AlbumSongsViewController *albumSongsViewController;
    
    UIViewController *current;
    
    UIViewController *viewToRemove;
}

-(void)changeToAllSongsView;
-(void)changeToIPodLibraryMainViewWithNowController:(NSString*)controller;
-(void)changeToAlbumController;
-(void)changeBackToAlbumController;
-(void)changeToCoverFlowView;
-(void)changeToAlbumSongsViewWithIndex:(int)index;

@end
