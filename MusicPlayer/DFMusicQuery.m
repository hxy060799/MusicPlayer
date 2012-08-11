//
//  DFMusicQuery.m
//  MusicPlayer
//
//  Created by Bill on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DFMusicQuery.h"
#import "DFSongInformation.h"

@implementation DFMusicQuery

-(void)allSongsQuery{
    //对所有歌曲的查询
    
    musicByTitle=[[[NSMutableArray alloc]init]retain];
    
    MPMediaQuery *myPlaylistsQuery = [MPMediaQuery songsQuery];  
    NSArray *collections = [myPlaylistsQuery collections];
    
    for (MPMediaPlaylist *playlist in collections){
        NSArray *songs = [playlist items];
        for (MPMediaItem *song in songs){
            [musicByTitle addObject:song];
        }
    }
    
    
    //输出部分
    for(int i=0;i<[musicByTitle count];i++){
        NSLog(@"%@",[[musicByTitle objectAtIndex:i] valueForProperty:MPMediaItemPropertyTitle]);
    }
     
}

-(void)artistQuery{
    //对歌手的查询，可以得到按歌手名排列的歌曲
    
    musicByArtist=[[NSMutableArray alloc]init];
    
    MPMediaQuery *artistQuery = [MPMediaQuery artistsQuery];
    NSArray *collections = [artistQuery collections];
    
    for (MPMediaItemCollection *artists in collections){
        [musicByArtist addObject:artists];
    }
    
    
    //输出部分
    for(MPMediaItemCollection *songs in musicByArtist){
        NSArray *songsArray=[songs items];
        for(MPMediaItem *song in songsArray){
            NSLog(@"%@--%@",[song valueForProperty:MPMediaItemPropertyTitle],[song valueForProperty:MPMediaItemPropertyArtist]);
            
        }
        NSLog(@"---------------");
    }
}

-(void)albumQuery{
    //对专辑的查询，可以得到按歌手名排列的歌曲
    
    musicByAlbum=[[NSMutableArray alloc]init];
    
    MPMediaQuery *albumsQuery = [MPMediaQuery albumsQuery];
    NSArray *collections = [albumsQuery collections];
    
    for (MPMediaItemCollection *albums in collections){
        [musicByAlbum addObject:albums];
    }
    
    
    //输出部分
    for(MPMediaItemCollection *songs in musicByAlbum){
        NSArray *songsArray=[songs items];
        for(MPMediaItem *song in songsArray){
            NSLog(@"%@--%@",[song valueForProperty:MPMediaItemPropertyTitle],[song valueForProperty:MPMediaItemPropertyAlbumTitle]);
            
        }
        NSLog(@"---------------");
    }
}

-(void)dealloc{
    [super dealloc];
}


@end
