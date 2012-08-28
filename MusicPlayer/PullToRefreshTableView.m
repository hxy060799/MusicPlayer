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
    

    if(self.frame.size.height<self.contentSize.height){
        [self setFooterRefreshViewHidden:NO];
    }else{
        [self setFooterRefreshViewHidden:YES];
    }
}

-(void)setFooterRefreshViewToCorrentFrame{
    [self.footerRefreshView setFrame:CGRectMake(0, self.contentSize.height+10, 320, 65)];
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

-(void)addFooterRefreshViewWithDelegate:(id<EGORefreshTableHeaderDelegate>)delegate{
    
    footerRefreshView=[[EGORefreshTableHeaderView alloc]initWithFrame:CGRectMake(0, self.contentSize.height+10, 320, 65) AndIsFooterView:YES];
    footerRefreshView.delegate=delegate;
    footerRefreshView.backgroundColor=[UIColor clearColor];
    [footerRefreshView refreshLastUpdatedDate];
    if(self.frame.size.height<self.contentSize.height){
        self.footerRefreshViewShowed=YES;
        [self addSubview:footerRefreshView];
    }else{
        self.footerRefreshViewShowed=NO;
    }
}

-(void)dealloc{
    [super dealloc];
    if(footerRefreshView)[footerRefreshView release];
}

@end
