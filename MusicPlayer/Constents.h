//
//  Constents.h
//  MusicPlayer
//
//  Created by Bill on 12-8-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

@class DFLyricsMusicPlayer;

#ifndef MusicPlayer_Constents_h
#define MusicPlayer_Constents_h

#define MUSIC_COUNT [musicByTitle count]

NSMutableArray *musicByTitle;
NSMutableArray *musicByArtist;
NSMutableArray *musicByAlbum;
DFLyricsMusicPlayer *manager;

BOOL musicSynced;

typedef enum{
    ViewPushWayLeft,
    ViewPushWayRight
}ViewPushWay;

#endif
