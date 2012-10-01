//
//  SongsTableViewController.h
//  MusicPlayer
//
//  Created by Bill on 12-8-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    DFMusicListTypeAllSongs,
    DFMusicListTypeArtistGroup,
    DFMusicListTypeArtistSongs,
    DFMusicListTypeAlbumGroup,
    DFMusicListTypeAlbumSongs
}DFMusicListType;

@interface SongsTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    UITableView *songsTableView;
    NSMutableArray *contentArray;
    DFMusicListType currentType;
    
    IBOutlet UINavigationBar *navigationBar;
}

@property(retain,nonatomic)UITableView *songsTableView;
@property(retain,nonatomic)NSMutableArray *contentArray;
@property(readwrite,nonatomic)DFMusicListType currentType;

-(void)setCellsWithContentArray:(NSMutableArray*)array ListType:(DFMusicListType)listType;
-(void)setCellsWithIndex:(int)index ListType:(DFMusicListType)listType;

@end
