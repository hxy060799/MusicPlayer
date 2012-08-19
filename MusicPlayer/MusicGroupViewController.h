//
//  MusicGroupViewController.h
//  MusicPlayer
//
//  Created by Bill on 12-8-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicGroupViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    UITableView *songsTableView;
    NSMutableArray *groupArray;
}
@property(retain,nonatomic)UITableView *songsTableView;
@property(retain,nonatomic)NSMutableArray *groupArray;

-(void)setTableViewWithMusicArray:(NSMutableArray*)array;

@end
