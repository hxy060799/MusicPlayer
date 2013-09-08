//
//  Constents.h
//  MusicPlayer
//
//  Created by Bill on 12-8-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

@class DFLyricsMusicPlayer;
@class DFOnlinePlayer;

#ifndef MusicPlayer_Constents_h
#define MusicPlayer_Constents_h

#define MUSIC_COUNT [musicByTitle count]

NSMutableArray *musicByTitle;
NSMutableArray *musicByArtist;
NSMutableArray *musicByAlbum;

DFLyricsMusicPlayer *manager;
int currentSongOfIndex;//当前播放歌曲在musicByTitle列表中的索引
BOOL isPlay;//是否正在播放状态

DFOnlinePlayer *onlinePlayer;

BOOL musicSynced;

typedef enum{
    ViewPushWayLeft,
    ViewPushWayRight
}ViewPushWay;

#endif
