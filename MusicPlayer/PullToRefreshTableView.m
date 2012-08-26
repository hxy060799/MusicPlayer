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
@synthesize footerRefreshViewShowed;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)reloadData{
    [super reloadData];
    
    if(footerRefreshViewShowed)[self.footerRefreshView setFrame:CGRectMake(0, self.contentSize.height+10, 320, 65)];
}

-(void)setFooterRefreshViewHidden:(BOOL)hidden{
    if(footerRefreshView){
        if(hidden){
            [self.footerRefreshView removeFromSuperview];
            self.footerRefreshViewShowed=NO;
        }else{
            [self addSubview:footerRefreshView];
            self.footerRefreshViewShowed=YES;
        }
    }
}

-(void)addHeaderRefreshViewWithFrame:(CGRect)frame IsFooterView:(BOOL)isFooterView Delegate:(id<EGORefreshTableHeaderDelegate>)delegate{
    if(!isFooterView){
        if(!headerRefreshView){
            self.headerRefreshView=[[[EGORefreshTableHeaderView alloc]initWithFrame:frame AndIsFooterView:NO]autorelease];
            self.headerRefreshView.delegate=delegate;
            self.headerRefreshView.backgroundColor=[UIColor clearColor];
            [self.headerRefreshView refreshLastUpdatedDate];
            [self addSubview:self.headerRefreshView];
        }
    }else{
        if((!footerRefreshView) && self.frame.size.height<self.contentSize.height){
            footerRefreshView=[[[EGORefreshTableHeaderView alloc]initWithFrame:CGRectMake(0, self.contentSize.height+10, 320, 65) AndIsFooterView:YES]autorelease];
            footerRefreshView.delegate=delegate;
            footerRefreshView.backgroundColor=[UIColor clearColor];
            [footerRefreshView refreshLastUpdatedDate];
            self.footerRefreshViewShowed=YES;
            [self addSubview:footerRefreshView];
        }
    }
}

-(void)dealloc{
    [super dealloc];
}

@end
