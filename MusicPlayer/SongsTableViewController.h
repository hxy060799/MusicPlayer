//
//  SongsTableViewController.h
//  MusicPlayer
//
//  Created by Bill on 12-8-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SongsTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    //其中包括一个Tableview
    UITableView *songsTableView;
    NSMutableArray *musicArray;
}

@property(retain,nonatomic)UITableView *songsTableView;
@property(retain,nonatomic)NSMutableArray *musicArray;

-(void)setTableViewWithMusicArray:(NSMutableArray*)array;

@end
