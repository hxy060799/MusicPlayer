//
//  QQLyricsGetter.m
//  MusicPlayer
//
//  Created by Bill on 12-9-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QQLyricsGetter.h"

@implementation QQLyricsGetter

@synthesize delegate;

-(id)init{
    if(self==[super init]){
        songTitle=[NSString string];
        songArtist=[NSString string];
        musicSearcher=[[QQMusicSearcher alloc]init];
        musicSearcher.delegate=self;
    }
    return self;
}

-(void)startGetLyricsWithTitle:(NSString*)title Artist:(NSString*)artist{
    songTitle=[title retain];
    songArtist=[artist retain];
    musicSearcher.delegate=self;
    [musicSearcher searchMusicWithTitle:title Artist:artist];
}

-(void)searchFinishedWithResult:(NSMutableArray *)result{
    NSInteger songIDResult=[QQMusicSearcher chooseLyricsWithLyricsResult:result Artist:songArtist];
    
    [musicSearcher getLyricsWithMusicID:songIDResult];
}

-(void)getLyricsFinishedWithResult:(NSString *)result{
    musicSearcher.delegate=nil;
    [musicSearcher autorelease];
    [songTitle autorelease];
    [songArtist autorelease];
    musicSearcher=nil;
    if(delegate){
        [delegate getLyrcsFinishedWithLyrics:result Getter:self];
    }
}

-(void)dealloc{
    if(musicSearcher)[musicSearcher release];
    [super dealloc];
}

@end
