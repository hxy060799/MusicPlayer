//
//  CoverFlowViewController.h
//  iPodLibraryViews
//
//  Created by Bill on 12-8-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapkuCoverFlow.h"
#import "CoverflowSelectViewController.h"

extern NSMutableArray *musicByAlbum;

@interface CoverFlowViewController : UIViewController<TKCoverflowViewDelegate,TKCoverflowViewDataSource,CoverFlowSelectViewDelegate>{
    TKCoverflowView *coverFlowView;
    NSMutableArray *covers;
    NSMutableArray *coversAlbumTitle;
    CoverflowSelectViewController *controller;
}

@property(retain,nonatomic)TKCoverflowView *coverFlowView;
@property(retain,nonatomic)NSMutableArray *covers;

@end
