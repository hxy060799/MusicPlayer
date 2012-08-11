//
//  DFMusicQuery.h
//  MusicPlayer
//
//  Created by Bill on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Constents.h"

extern NSMutableArray *musicByTitle;
extern NSMutableArray *musicByArtist;
extern NSMutableArray *musicByAlbum;

@interface DFMusicQuery : NSObject{
    //NSMutableArray *artists;
    NSMutableArray *albumInformation;
}

-(void)allSongsQuery;
-(void)artistQuery;
-(void)albumQuery;

@end
