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

@property(retain,nonatomic)EGORefreshTableHeaderView *headerRefreshView;
@property(retain,nonatomic)EGORefreshTableHeaderView *footerRefreshView;

-(void)addHeaderRefreshViewWithFrame:(CGRect)frame IsFooterView:(BOOL)isFooterView Delegate:(id<EGORefreshTableHeaderDelegate>)delegate;

@end
