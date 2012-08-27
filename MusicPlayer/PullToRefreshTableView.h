//
//  PullToRefreshTableView.h
//  MusicPlayer
//
//  Created by Bill on 12-8-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@interface PullToRefreshTableView : UITableView

//@property(retain,nonatomic)EGORefreshTableHeaderView *headerRefreshView;
@property(retain,nonatomic)EGORefreshTableHeaderView *footerRefreshView;
@property(assign,nonatomic)BOOL footerRefreshViewShowed;

-(void)addFooterRefreshViewWithDelegate:(id<EGORefreshTableHeaderDelegate>)delegate;
-(void)setFooterRefreshViewHidden:(BOOL)hidden;
-(void)setFooterRefreshViewToCorrentFrame;
@end
