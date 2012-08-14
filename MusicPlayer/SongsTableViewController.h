//
//  SongsTableViewController.h
//  MusicPlayer
//
//  Created by Bill on 12-8-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TKEmptyView;

@interface SongsTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    //其中包括一个Tableview和一个EmptyView
    UITableView *songsTableView;
    TKEmptyView *emptyView;
}

@property(retain,nonatomic)UITableView *songsTableView;
@property(retain,nonatomic)TKEmptyView *emptyView;

@end
