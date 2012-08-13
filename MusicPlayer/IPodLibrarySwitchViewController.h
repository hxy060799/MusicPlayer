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
#import "Constents.h"

extern BOOL musicSynced;

@interface IPodLibrarySwitchViewController : UIViewController{
    IPodLibraryMainViewController *first;
    AllSongsViewController *second;
    AlbumViewController *albumController;
    CoverFlowViewController *coverFlowViewController;
    
    UIViewController *current;
    
    UIViewController *viewToRemove;
}

-(void)changeToAllSongsView;
-(void)changeToIPodLibraryMainViewWithNowController:(NSString*)controller;
-(void)changeToAlbumController;
-(void)changeToCoverFlowView;

@end
