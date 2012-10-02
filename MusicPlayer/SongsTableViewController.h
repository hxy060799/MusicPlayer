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

struct MusicListInformation{
    DFMusicListType listType;//歌曲菜单的类型
    int listSuperIdnex;//列表类型为单个歌手/专辑时来表示这个专辑或者歌手在组里面的索引
};

@interface SongsTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    UITableView *songsTableView;
    struct MusicListInformation currentType;
    
    IBOutlet UINavigationBar *navigationBar;
}

@property(retain,nonatomic)UITableView *songsTableView;
//@property(retain,nonatomic)NSMutableArray *contentArray;
@property(readwrite,nonatomic)struct MusicListInformation currentType;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil listInformation:(struct MusicListInformation)information;

//(void)setCellsWithContentArray:(NSMutableArray*)array ListType:(DFMusicListType)listType;
//-(void)setCellsWithIndex:(int)index ListType:(DFMusicListType)listType;

struct MusicListInformation MusicListInformationMake(DFMusicListType listType,int listSuperIdnex);

@end
