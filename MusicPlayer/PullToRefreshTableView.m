//
//  PullToRefreshTableView.m
//  MusicPlayer
//
//  Created by Bill on 12-8-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PullToRefreshTableView.h"

@implementation PullToRefreshTableView

@synthesize footerRefreshView;
@synthesize headerRefreshView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



-(void)addHeaderRefreshViewWithFrame:(CGRect)frame IsFooterView:(BOOL)isFooterView Delegate:(id<EGORefreshTableHeaderDelegate>)delegate{
    if(!isFooterView){
        if(!headerRefreshView){
            self.headerRefreshView=[[EGORefreshTableHeaderView alloc]initWithFrame:frame AndIsFooterView:NO];
            self.headerRefreshView.delegate=delegate;
            self.headerRefreshView.backgroundColor=[UIColor clearColor];
            [self.headerRefreshView refreshLastUpdatedDate];
            [self addSubview:self.headerRefreshView];
        }
    }else{
        if((!footerRefreshView) && self.frame.size.height<self.contentSize.height){
            footerRefreshView=[[EGORefreshTableHeaderView alloc]initWithFrame:CGRectMake(0, self.contentSize.height, 320, 65) AndIsFooterView:YES];
            footerRefreshView.delegate=delegate;
            footerRefreshView.backgroundColor=[UIColor clearColor];
            [footerRefreshView refreshLastUpdatedDate];
            [self addSubview:footerRefreshView];
        }
    }
}

-(void)dealloc{
    if(self.headerRefreshView)[self.headerRefreshView release];
    if(self.footerRefreshView)[self.footerRefreshView release];
    [super dealloc];
}

@end
