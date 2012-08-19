//
//  Loading.m
//  MusicPlayer
//
//  Created by Bill on 12-8-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Loading.h"
#import "DFMusicQuery.h"

@implementation Loading

-(void)query{
    DFMusicQuery *query=[[DFMusicQuery alloc]init];
    [query allSongsQuery];
    [query albumQuery];
    [query artistQuery];
    [query release];
}

@end
