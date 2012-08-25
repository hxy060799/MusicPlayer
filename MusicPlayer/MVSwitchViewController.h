//
//  MVSwitchViewController.h
//  MusicPlayer
//
//  Created by Bill on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCSearchController.h"
#import "PullToRefreshTableView.h"

#import "EGORefreshTableHeaderView.h"

struct tableViewPagesArray{
    NSMutableArray *tableViewArray;
    int nowPageAt;
};

@interface MVSwitchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,YCSearchControllerDelegete,EGORefreshTableHeaderDelegate>{
    PullToRefreshTableView *mvTableView;
    //NSMutableArray *tableViewArray;
    //NSMutableArray *searchArray;
    struct tableViewPagesArray hotMVResult;
    struct tableViewPagesArray searchResult;
    IBOutlet UINavigationBar *navigationBar;
    
    UISearchDisplayController *searchDisplayController;
    BOOL displaySearch;
    
    BOOL reloading;
    
    EGORefreshTableHeaderView *refreshHeaderView;
    EGORefreshTableHeaderView *refreshFooterView;
    
    YCSearchController *searchController;
}

-(void)segmentedControlChanged:(UISegmentedControl*)segmentedControl;

@end
