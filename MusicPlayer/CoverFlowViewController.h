//
//  CoverFlowViewController.h
//  iPodLibraryViews
//
//  Created by Bill on 12-8-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapkuCoverFlow.h"

extern NSMutableArray *musicByAlbum;

@interface CoverFlowViewController : UIViewController<TKCoverflowViewDelegate,TKCoverflowViewDataSource>{
    TKCoverflowView *coverFlowView;
    NSMutableArray *covers;
    NSMutableArray *coversAlbumTitle;
}

@property(retain,nonatomic)TKCoverflowView *coverFlowView;
@property(retain,nonatomic)NSMutableArray *covers;

@end
